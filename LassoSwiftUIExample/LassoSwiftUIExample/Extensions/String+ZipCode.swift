//
//  String+ZipCode.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/5/21.
//

import Foundation

extension String {

    var isZipCode: Bool {
        if !isEmpty {
            if count == 5 {
                return Int(self) != nil
            }
        }
        return false
    }

}
