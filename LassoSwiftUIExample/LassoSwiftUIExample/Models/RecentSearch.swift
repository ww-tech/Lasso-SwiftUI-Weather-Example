//
//  RecentSearch.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/9/21.
//

import Foundation

struct RecentSearch: Identifiable, Equatable, Codable {
    var id: String { zipCode }
    let zipCode: String
    let cityName: String
}

// MARK: - User Defaults Key
private extension RecentSearch {
    static let userDefaultsKey = "recent_searches"
}

// MARK: - Load from User Defaults
extension RecentSearch {
    static func load() -> [RecentSearch] {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            if let searches = try? PropertyListDecoder().decode([RecentSearch].self, from: data) {
                return searches
            }
        }

        return []
    }
}

// MARK: - Save to User Defaults
extension Array where Element == RecentSearch {

    func saveToUserDefaults() {
        if let data = try? PropertyListEncoder().encode(self) {
            UserDefaults.standard.set(data, forKey: RecentSearch.userDefaultsKey)
        }
    }

}
