//
//  WeatherRepo.swift
//  CurrentWeatherResult
//
//  Created by KimRin on 10/28/24.
//

import Foundation
import RxSwift

struct WeatherRepo {
    private let networkManager = NetworkManager.shared
    
    private let urlQueryItem: [URLQueryItem] = [
        URLQueryItem(name: "lat", value: "37.5"),
        URLQueryItem(name: "lon", value: "126.9"),
        URLQueryItem(name: "appid", value: "4b4ab08dfbebc4502aa246da27e874e4"),
        URLQueryItem(name: "units", value: "metric")
    ]
    
    //값을 받아와서 어떠한 구조체로 보낸다?
    func fetchCurrentWeatherData() -> Single<CurrentWeatherResult> {
        var urlComponents = URLComponents(string: "\(K.API.baseURL)weather")
        urlComponents?.queryItems = urlQueryItem
        
        guard let url = urlComponents?.url
        else {
            print("잘못된 URL")
            return Single.error(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        }
        return networkManager.fetch(url: url)
        
    }
    
    func fetchForecastWeatherData() -> Single<ForecastWeatherResult> {
        var urlComponets = URLComponents(string: "\(K.API.baseURL)forecast")
        urlComponets?.queryItems = urlQueryItem
        
        guard let url = urlComponets?.url
        else {
            print("잘못된 URL")
            return Single.error(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        }
        return networkManager.fetch(url: url)
            
    }
    
}
