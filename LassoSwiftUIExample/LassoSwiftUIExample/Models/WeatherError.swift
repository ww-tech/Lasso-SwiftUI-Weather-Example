//
//  WeatherError.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/9/21.
//

import Foundation

enum WeatherError: RawRepresentable, Identifiable, Error, LocalizedError, Equatable {
    // Cases
    case invalidZipCode
    case cityNotFound
    case custom(Error)
    case unknown
    case serverError
	case unauthorized

    // Identifiable
    var id: Int { rawValue }

    // Description
    var errorDescription: String? {
        switch self {
        case .invalidZipCode:
            return NSLocalizedString("The provided zip code is invalid.", comment: "Invalid Zip Code")
        case .cityNotFound:
            return NSLocalizedString("The provided zip code does not correspond to a valid city.", comment: "City not Found")
        case .custom(let error):
            return error.localizedDescription
        case .unknown:
            return NSLocalizedString("An unknown error occurred.", comment: "Unknown Error")
        case .serverError:
            return NSLocalizedString("The server seems to be having problems. Please try again.", comment: "Server Error")
		case .unauthorized:
			return NSLocalizedString("Unauthorized access. Make sure you've added you OpenWeather API Key to the `Config.xcconfig` file.", comment: "Unauthorized Error")
        }
    }

    // RawRepresentable
    init?(rawValue: Int) { fatalError() }

    var rawValue: Int {
        switch self {
        case .invalidZipCode: return 0
        case .cityNotFound: return 1
        case .custom: return 2
        case .unknown: return 3
        case .serverError: return 4
		case .unauthorized: return 5
        }
    }
}
