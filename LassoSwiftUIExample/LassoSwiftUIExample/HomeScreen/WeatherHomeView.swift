//
//  WeatherHomeView.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/5/21.
//

import SwiftUI
import Lasso

struct WeatherHomeView: View, LassoView {

	@ObservedObject private(set) var store: HomeScreen.ViewStore
    
    var body: some View {
        VStack(spacing: 0) {
            locationSearchBar

            List {
                Section(header: Text("Recent Searches")) {
                    ForEach(state.recentSearches, content: recentSearchRow)
                        .onDelete(store) { .didDeleteRecentSearch(indexSet: $0) }
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationBarTitle("Weather")
        .alert(item: searchErrorBinding, content: searchErrorAlert)
        .onTapGesture(perform: KeyboardManager.hideKeyboard)
        .overlay(loadingView)
    }

    // MARK: - Search Bar

    private var locationSearchBar: some View {
        let searchBinding = store.binding(\.searchZipCode, action: searchBarBindingAction)

        return HStack {
            SearchBar(placeholder: "Enter Location Zip Code", text: searchBinding)
            Button("Search", target: store, action: .didTapSearch)
                .padding(.trailing)
        }
    }

    private func searchBarBindingAction(
        newZipCode: String
	) -> HomeScreen.Action {
        .didEditZipCode(newZipCode)
    }

    // MARK: - Location Row
    private func recentSearchRow(for recentSearch: RecentSearch) -> some View {
        NavigationRow(store, action: .didTapRecentSearch(recentSearch)) {
            RecentSearchPreview(recentSearch: recentSearch)
        }
    }

    // MARK: - Alert
    private var searchErrorBinding: Binding<WeatherError?> {
        store.binding(\.searchError, action: searchErrorBindingAction)
    }

    private func searchErrorBindingAction(
        error: WeatherError?
	) -> HomeScreen.Action {
        .didDismissErrorAlert
    }

    private func searchErrorAlert(
        error: WeatherError
    ) -> Alert {
        Alert(
            title: Text("Search Error"),
            message: Text(error.localizedDescription)
        )
    }

    // MARK: - Is Loading View
    @ViewBuilder
    private var loadingView: some View {
        if state.isSearching {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .overlay(
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                )
        }
    }
}

struct WeatherHomeView_Previews: PreviewProvider {
    static var previews: some View {
		let homeStore = HomeScreenStore()
		return WeatherHomeView(store: homeStore.asViewStore())
    }
}
