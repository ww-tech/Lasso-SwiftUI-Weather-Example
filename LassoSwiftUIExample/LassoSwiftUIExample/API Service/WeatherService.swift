//
//  WeatherService.swift
//  LassoSwiftUIExample
//
//  Created by Charles Pisciotta on 8/5/21.
//

import Foundation
import Combine

final class WeatherService {

    let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    // API Key Disclaimer:
    //
    // In this example we will be hard coding an API key into the application's source code. This is not
    // something that is recommended for production systems and is only being done for simplicity within
    // this example. In a production scenario, this call would be proxied through your own API microservice
    // in order to protect the API key from being visible to anyone using the client side application.
    #warning("Replace `YOUR_API_KEY_HERE` with your OpenWeather API key.")
    private let apiKey = "YOUR_API_KEY_HERE"

    private func constructAPIURL(
        zipCode: String,
        countryCode: String = "US"
    ) -> URL? {
        guard var components = URLComponents(string: baseURL) else { return nil }
        
        let zipCodeQuery = URLQueryItem(name: "zip", value: "\(zipCode),\(countryCode)")
        let apiKeyQuery = URLQueryItem(name: "appid", value: apiKey)

        // Check if the user's locale uses imperial or metric system
        let unitsQueryValue = Locale.current.usesMetricSystem ? "metric" : "imperial"
        let unitsQuery = URLQueryItem(name: "units", value: unitsQueryValue)

        components.queryItems = [zipCodeQuery, apiKeyQuery, unitsQuery]

        return components.url
    }

    func getCurrentWeather(
        zipCode: String,
        countryCode: String = "US"
    ) -> AnyPublisher<Weather, Error> {
        let url = constructAPIURL(zipCode: zipCode, countryCode: countryCode)!

        return urlSession.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) in
                guard let response = response as? HTTPURLResponse else {
                    throw WeatherError.unknown
                }

                switch response.statusCode {
                case 200...299: return data
                case 401: throw WeatherError.unauthorized
                case 404: throw WeatherError.cityNotFound
                case 500...599: throw WeatherError.serverError
                default: throw WeatherError.unknown
                }
            })
            .mapError { $0 as Error }
            .decode(type: Weather.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}
