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
        // 날씨 데이터를 로드하는 Observable
        let loadTrigger = Observable.merge(input.loadCurrentWeather, input.updateLocation)
        
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
            
        
        
//        input.loadCurrentWeather
//            .withUnretained(self)
//            .flatMapLatest { owner, _ in
//                owner.repository.fetchCurrentWeatherData(urlQueryItem: query)
//                    .asObservable()
//            }
//            .subscribe(onNext: { [weak self] data in
//                self?.currentWeatherRelay.accept(data)
//            }, onError: {error in
//                print(error.localizedDescription)
//            })
//            .disposed(by: disposeBag)
//        input.loadCurrentWeather
//            .withUnretained(self)
//            .flatMapLatest { owner, _ in
//                owner.repository.fetchForecastWeatherData(urlQueryItem: query)
//                    .asObservable()
//            }.subscribe(onNext: { [weak self] data in
//                self?.forecastWeatherRelay.accept(data)
//            }, onError: { error in
//                print(error.localizedDescription)
//            }).disposed(by: disposeBag)
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
