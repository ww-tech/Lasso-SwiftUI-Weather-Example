//
//  RecentSearchPreview.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/9/21.
//

import SwiftUI

struct RecentSearchPreview: View {

    let recentSearch: RecentSearch

    var body: some View {
        VStack(alignment: .leading) {
            Text(recentSearch.cityName)
                .font(.headline)

            Text(recentSearch.zipCode)
                .font(.subheadline)
        }
    }
}

struct RecentSearchPreview_Previews: PreviewProvider {
    static var previews: some View {
        let recentSearch = RecentSearch(zipCode: "10010", cityName: "New York City")
        RecentSearchPreview(recentSearch: recentSearch)
    }
}
