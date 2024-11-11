//
//  MainVM.swift
//  CurrentWeatherResult
//
//  Created by KimRin on 10/27/24.
//

import Foundation
import RxSwift
import RxCocoa

class MainVM {
    
    let currentWeatherRelay = BehaviorRelay<CurrentWeatherResult?>(value: nil)
    let forecastWeatherRelay = BehaviorRelay<ForecastWeatherResult?>(value: nil)
    private let latitudeRelay = BehaviorRelay<Double>(value: 40.56)
    private let longtitudeRelay = BehaviorRelay<Double>(value: 126.97)

    private let repository = WeatherRepo()
    
    
    
    private let disposeBag = DisposeBag()
    init() {}
    
    func transform(input: Input) -> Output {
        //두가지의 스트림을 merge하고
        let loadTrigger = Observable.merge(input.loadCurrentWeather, input.updateLocation)
        // query는 최신값을 받아올수 있도록
        let query = Observable.combineLatest(latitudeRelay, longtitudeRelay)
            .map { lat, lon in
            return [
                URLQueryItem(name: "lat", value: String(lat)),
                URLQueryItem(name: "lon", value: String(lon)),
                URLQueryItem(name: "appid", value: K.API.apiKey),
                URLQueryItem(name: "units", value: "metric")
            ]}
        
        loadTrigger
            .withLatestFrom(query)
            .flatMapLatest { [unowned self] queryItems in
                //unowned가 쓰인이유는 self가 100프로 있다고 확신, nil 체킹을 반복하지 않도록
                self.repository.fetchCurrentWeatherData(urlQueryItem: queryItems).asObservable()
            }
            .bind(to: currentWeatherRelay)
            .disposed(by: disposeBag)
        
        loadTrigger
            .withLatestFrom(query)
            .flatMapLatest { [unowned self] queryItems in
                self.repository.fetchForecastWeatherData(urlQueryItem: queryItems).asObservable()
            }
            .bind(to: forecastWeatherRelay)
            .disposed(by: disposeBag)
            
        
        return Output(currentWeather: currentWeatherRelay, forecastWeatherResult: forecastWeatherRelay)
    }
    
    func updateLocation(latitude: Double, longtitude: Double) {
        
        print(latitude,longtitude)
        
        latitudeRelay.accept(latitude)
        longtitudeRelay.accept(longtitude)
        
    }
    
    
    struct Input {
        let loadCurrentWeather: Observable<Void>
        let updateLocation: Observable<Void>
    }
    
    struct Output {
        let currentWeather: BehaviorRelay<CurrentWeatherResult?>
        let forecastWeatherResult: BehaviorRelay<ForecastWeatherResult?>
    }
    
}
