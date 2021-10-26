//
//  HomeScreen.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/29/21.
//

import Foundation
import Lasso

enum HomeScreen: ScreenModule {

	struct State: Equatable {
		var isSearching: Bool = false
		var searchError: WeatherError? = nil
		var isValidZipCode = false
		var searchZipCode: String = ""
		var recentSearches: [RecentSearch] = RecentSearch.load()
	}

	enum Action: Equatable {
		case didEditZipCode(String)
		case didTapSearch
		case didDismissErrorAlert
		case didTapRecentSearch(RecentSearch)
		case didDeleteRecentSearch(indexSet: IndexSet)
	}

	enum Output: Equatable {
		case showDetail(_ weather: Weather)
	}

	static var defaultInitialState: State { State() }

	static func createScreen(with store: HomeScreenStore) -> Screen {
		let homeView = WeatherHomeView(store: store.asViewStore())
		return Screen(store, homeView)
	}

}
