//
//  DetailScreenStore.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/29/21.
//

import Foundation
import Lasso

final class DetailScreenStore: LassoStore<DetailScreen> {

	override func handleAction(_ action: LassoStore<DetailScreen>.Action) {
		switch action {
		case .didTapMap:
			guard let coordinates = state.coordinates else { return }
			self.dispatchOutput(.didTapMap(coordinates))
		}
	}

}
