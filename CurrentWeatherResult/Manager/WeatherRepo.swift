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
  
    
    //값을 받아와서 어떠한 구조체로 보낸다?
    func fetchCurrentWeatherData(urlQueryItem: [URLQueryItem]) -> Single<CurrentWeatherResult> {
        var urlComponents = URLComponents(string: "\(K.API.baseURL)weather")
        urlComponents?.queryItems = urlQueryItem
        
        guard let url = urlComponents?.url
        else {
            print("잘못된 URL")
            return Single.error(NSError(domain: "Invalid URL", code: -1, userInfo: nil))
        }
        print(url)
        return networkManager.fetch(url: url)
        
    }
    
    func fetchForecastWeatherData(urlQueryItem: [URLQueryItem]) -> Single<ForecastWeatherResult> {
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
