//
//  CurrentWeatherResult.swift
//  CurrentWeatherResult
//
//  Created by bloom on 7/11/24.
//

import Foundation


struct CurrentWeatherResult: Codable{
    let weather: [Weather]
    let main: WeatherMain
    let name: String
    let wind: Wind
    let dt: Int

}

struct Weather: Codable {
    let id: Int //weatherCondition
    let main: String
    let description: String // weatherStatus
    let icon: String // weatherImage
}


struct WeatherMain: Codable {
    let temp: Double // currentTemp
    let feelsLike: Double // human feels like
    let tempMin: Double // min temp
    let tempMax: Double // max temp
    let humidity: Double // 습도
    
    enum CodingKeys: String, CodingKey {
        case temp, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case feelsLike = "feels_like"
    }
    

}

struct Wind: Codable {
    let speed: Double // speed everage
    let deg: Double // speed way
    let gust: Double // fastest speed
}

/*
 // Unix 타임스탬프
 let unixTimestamp: TimeInterval = 1726660758

 // 타임스탬프를 Date로 변환
 let date = Date(timeIntervalSince1970: unixTimestamp)

 // DateFormatter를 사용해 사람이 읽을 수 있는 형식으로 변환
 let dateFormatter = DateFormatter()
 dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
 dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // UTC 시간대 설정

 // 변환된 날짜 출력
 let formattedDate = dateFormatter.string(from: date)
 print("Converted Date: \(formattedDate)")
 */
