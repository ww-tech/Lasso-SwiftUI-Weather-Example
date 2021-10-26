//
//  WeatherDetailView.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/6/21.
//

import SwiftUI
import Lasso

struct WeatherDetailView: View, LassoView {

	@ObservedObject private(set) var store: DetailScreen.ViewStore

    var body: some View {
        Image(state.weatherCategory)
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.bottom)
            .overlay(overlayView)
            .navigationBarTitle(state.cityName)
            .navigationBarItems(trailing: navigationTrailingItem)
    }

    private var navigationTrailingItem: some View {
        Button(store, action: .didTapMap) { Image(systemName: "map") }
    }

    private var overlayView: some View {
        VStack {
            Text(state.weatherCategory)
                .font(.largeTitle)
            Text(state.temperature)
                .font(.system(size: 100))
        }
        .foregroundColor(.white)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10.0)
				.foregroundColor(Color.gray.opacity(0.5))
        )
    }

}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
		let initialState = DetailScreen.State(weather: .mock)
		let detailStore = DetailScreenStore(with: initialState)
		return WeatherDetailView(store: detailStore.asViewStore())
    }
}
