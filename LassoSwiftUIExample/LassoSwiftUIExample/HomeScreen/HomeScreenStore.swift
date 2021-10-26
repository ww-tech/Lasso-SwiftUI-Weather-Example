//
//  HomeScreenStore.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/29/21.
//

import Foundation
import Lasso
import Combine

final class HomeScreenStore: LassoStore<HomeScreen> {

	private let weatherService: WeatherService
	private var weatherServiceCancellable: AnyCancellable?

	init(weatherService: WeatherService) {
		self.weatherService = weatherService
		super.init(with: LassoStore<HomeScreen>.State())
	}

	required init(with initialState: LassoStore<HomeScreen>.State) {
		self.weatherService = WeatherService()
		super.init(with: initialState)
	}

	override func handleAction(_ action: LassoStore<HomeScreen>.Action) {
		switch action {
		case .didEditZipCode(let zipCode):
			update { $0.searchZipCode = zipCode }

		case .didTapSearch:
			guard checkIsValidZipCode() else { return }
			handleDidTapSearch(for: state.searchZipCode)
			clearSearchBar()

		case .didDismissErrorAlert:
			update { $0.searchError = nil }

		case .didTapRecentSearch(let recentSearch):
			handleDidTapSearch(for: recentSearch.zipCode)

		case .didDeleteRecentSearch(let indexSet):
			handleDeleteRecentSearch(at: indexSet)
		}
	}

	private func clearSearchBar() {
		update { $0.searchZipCode = "" }
	}

	private func handleDeleteRecentSearch(at indexSet: IndexSet) {
		update { state in
			state.recentSearches.remove(atOffsets: indexSet)
			state.recentSearches.saveToUserDefaults()
		}
	}

	private func checkIsValidZipCode() -> Bool {
		if state.searchZipCode.isZipCode {
			return true
		}

		// Invalid
		self.update { $0.searchError = .invalidZipCode }

		return false
	}

	private func addRecentSearch(_ recentSearch: RecentSearch) {
		// Check if already added to recent searches
		guard !state.recentSearches.contains(recentSearch) else { return }

		update { $0.recentSearches.append(recentSearch) }
		state.recentSearches.saveToUserDefaults()
	}

	private func handleDidTapSearch(for zipCode: String) {
		KeyboardManager.hideKeyboard()
		handleSearch(for: zipCode)
	}

	private func handleSearch(for zipCode: String) {
		func handleCompletion(value: Subscribers.Completion<Error>) {
			update { $0.isSearching = false }

			switch value {
			case .failure(let error):
				self.update { $0.searchError = WeatherError.custom(error) }

			case .finished:
				return
			}
		}

		func handleReceiveValue(weather: Weather) {
			update { $0.isSearching = false }
			self.dispatchOutput(.showDetail(weather))

			// Add Recent Search on Successful Search
			let recentSearch = RecentSearch(zipCode: zipCode, cityName: weather.cityName)
			addRecentSearch(recentSearch)
		}

		update { $0.isSearching = true }

		self.weatherServiceCancellable = weatherService
			.getCurrentWeather(zipCode: zipCode)
			.sink(receiveCompletion: handleCompletion, receiveValue: handleReceiveValue)
	}

}
