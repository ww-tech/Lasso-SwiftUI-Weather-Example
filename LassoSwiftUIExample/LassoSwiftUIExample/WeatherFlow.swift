//
//  WeatherFlow.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/6/21.
//

import UIKit
import SwiftUI
import Lasso

final class WeatherFlow: Flow<NoOutputNavigationFlow> {

	override func createInitialController() -> UIViewController {
		HomeScreen
			.createScreen()
			.observeOutput { [weak self] in self?.handleHomeScreenOutput($0) }
			.controller
	}

	// MARK: - Home Screen

	private func handleHomeScreenOutput(_ output: HomeScreen.Output) {
		switch output {
		case .showDetail(let weather):
			createDetailController(with: weather)
				.place(with: nextPushedInFlow)
		}
	}

	// MARK: - Detail Screen

	private func createDetailController(with weather: Weather) -> UIViewController {
		let initialState = DetailScreen.State(weather: weather)
		
		return DetailScreen
			.createScreen(with: initialState)
			.observeOutput { [weak self] in self?.handleDetailScreenOutput($0) }
			.controller
	}

	private func handleDetailScreenOutput(_ output: DetailScreen.Output) {
		switch output {
		case .didTapMap(let coordinates):
			createMapController(coordinates: coordinates)
				.place(with: nextPushedInFlow)
		}
	}

	// MARK: - Map Screen

	private func createMapController(coordinates: Weather.Coordinates) -> UIViewController {
		let mapView = MapView(coordinates: coordinates).edgesIgnoringSafeArea(.all)
		return UIHostingController(rootView: mapView)
	}

}
