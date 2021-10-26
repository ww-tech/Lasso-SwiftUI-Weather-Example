//
//  DetailScreen.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/29/21.
//

import Foundation
import Lasso

enum DetailScreen: ScreenModule {

	struct State: Equatable {
		// Properties
		private var weather: Weather

		// Computed Properties
		var weatherCategory: String { weather.weatherElement.first?.main.rawValue ?? "" }
		var cityName: String { weather.cityName }
		var temperature: String { weather.main.temperature.asTemperature }
		var coordinates: Weather.Coordinates? { weather.coordinates }

		// Custom init
		init(weather: Weather) {
			self.weather = weather
		}
	}

	enum Action: Equatable {
		case didTapMap
	}

	enum Output: Equatable {
		case didTapMap(Weather.Coordinates)
	}

	static var defaultInitialState: State {
		fatalError("DetailScreen should never use `defaultInitialState`. Use `State.init`.")
	}

	static func createScreen(with store: DetailScreenStore) -> Screen {
		let detailView = WeatherDetailView(store: store.asViewStore())
		return Screen(store, detailView)
	}
}
