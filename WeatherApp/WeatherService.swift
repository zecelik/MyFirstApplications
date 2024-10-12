//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Zehra on 10.10.2024.
//

import Foundation


struct WeatherResponse: Codable {
    let main: MainWeatherData
    let weather: [WeatherCondition]
    let name: String
}


struct MainWeatherData: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}


struct WeatherCondition: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

class WeatherService {
    let apiKey = "f9c4935fff362236aa269a9d1402c73d"
    let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(for city: String, completion: @escaping (WeatherResponse?) -> Void) {
        // URL'yi oluşturma
        let urlString = "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            completion(nil)
            return
        }
        

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching weather data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data returned.")
                completion(nil)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
                completion(weatherResponse)
            } catch {
                print("Error decoding weather data: \(error)")
                completion(nil)
            }
        }.resume()
    }
}


