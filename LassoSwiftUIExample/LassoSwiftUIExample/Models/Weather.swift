//
//  Weather.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/5/21.
//

import Foundation

// MARK: - Weather
struct Weather: Decodable, Equatable {
	let coordinates: Coordinates
	let weatherElement: [WeatherElement]
	let base: String
	let main: MainWeather
	let visibility: Int
	let wind: Wind
	let clouds: Clouds
	let calculationTime: Date
	let other: OtherData
	let id: Int
	let cityName: String

	enum CodingKeys: String, CodingKey {
		case coordinates = "coord"
		case weatherElement = "weather"
		case base
		case main
		case visibility
		case wind
		case clouds
		case calculationTime = "dt"
		case other = "sys"
		case id
		case cityName = "name"
	}
}

// MARK: - Coordinates
extension Weather {
	struct Coordinates: Decodable, Equatable {
		let latitude: Double
		let longitude: Double

		enum CodingKeys: String, CodingKey {
			case latitude = "lat"
			case longitude = "lon"
		}
	}
}

// MARK: - Weather Element
extension Weather {
	struct WeatherElement: Decodable, Equatable {
		let id: Int
		let main: WeatherCategory
		let weatherDescription: String
		let icon: String

		enum CodingKeys: String, CodingKey {
			case id, main
			case weatherDescription = "description"
			case icon
		}
	}

	enum WeatherCategory: String, Decodable, Equatable {
		case thunderstorm = "Thunderstorm"
		case drizzle = "Drizzle"
		case rain = "Rain"
		case mist = "Mist"
		case smoke = "Smoke"
		case haze = "Haze"
		case dust = "Dust"
		case fog = "Fog"
		case sand = "Sand"
		case ash = "Ash"
		case squall = "Squall"
		case tornado = "Tornado"
		case clear = "Clear"
		case clouds = "Clouds"
		case snow = "Snow"
		case unknown = "Weather Unknown"

		init?(rawValue: String) {
			switch rawValue {
			case "Thunderstorm": self = .thunderstorm
			case "Drizzle": self = .drizzle
			case "Rain": self = .rain
			case "Mist": self = .mist
			case "Smoke": self = .smoke
			case "Haze": self = .haze
			case "Dust": self = .dust
			case "Fog": self = .fog
			case "Sand": self = .sand
			case "Ash": self = .ash
			case "Squall": self = .squall
			case "Tornado": self = .tornado
			case "Clear": self = .clear
			case "Clouds": self = .clouds
			case "Snow": self = .snow
			default: self = .unknown
			}
		}
	}
}

// MARK: - Main
extension Weather {
	struct MainWeather: Decodable, Equatable {
		let temperature: Double
		let feelsLike: Double
		let minimumTemperature: Double
		let maximumTemperature: Double
		let pressure: Int
		let humidity: Int

		enum CodingKeys: String, CodingKey {
			case temperature = "temp"
			case feelsLike = "feels_like"
			case minimumTemperature = "temp_min"
			case maximumTemperature = "temp_max"
			case pressure
			case humidity
		}
	}
}

// MARK: - Wind
extension Weather {
	struct Wind: Decodable, Equatable {
		let speed: Double
		let degrees: Int
		let gust: Double?

		enum CodingKeys: String, CodingKey {
			case speed
			case degrees = "deg"
			case gust
		}
	}
}

// MARK: - Clouds
extension Weather {
	struct Clouds: Decodable, Equatable {
		let all: Int
	}
}

// MARK: - Other
extension Weather {
	struct OtherData: Decodable, Equatable {
		let type: Int
		let id: Int
		let country: String
		let sunrise: Date
		let sunset: Date
	}
}

// MARK: - Mock Weather Object
#if DEBUG
extension Weather {
	static var mock: Weather {
		let coordinates = Coordinates(latitude: 37.39, longitude: -122.08)
		let weatherElement = WeatherElement(id: 800, main: .clear, weatherDescription: "clear sky", icon: "01d")
		let base = "stations"
		let mainWeather = MainWeather(temperature: 81, feelsLike: 82, minimumTemperature: 77, maximumTemperature: 85, pressure: 1023, humidity: 80)
		let visibility = 16093
		let wind = Wind(speed: 1.5, degrees: 350, gust: nil)
		let clouds = Clouds(all: 1)
		let calculationTime = Date(timeIntervalSince1970: 1560350645)
		let otherData = OtherData(type: 1, id: 5122, country: "US", sunrise: Date(timeIntervalSince1970: 1560343627), sunset: Date(timeIntervalSince1970: 1560396563))
		let id = 420006353
		let cityName = "Mountain View"

		return Weather(coordinates: coordinates,
					   weatherElement: [weatherElement],
					   base: base,
					   main: mainWeather,
					   visibility: visibility,
					   wind: wind,
					   clouds: clouds,
					   calculationTime: calculationTime,
					   other: otherData,
					   id: id,
					   cityName: cityName)
	}
}
#endif
