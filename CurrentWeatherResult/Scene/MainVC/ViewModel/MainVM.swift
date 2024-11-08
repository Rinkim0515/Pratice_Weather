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
    private let repository = WeatherRepo()
    
    private let disposeBag = DisposeBag()
    init() {}


    

    func transform(input: Input) -> Output {
        // 날씨 데이터를 로드하는 Observable
        input.loadCurrentWeather
            .flatMapLatest { [weak self] in
                self?.repository.fetchCurrentWeatherData()
                    .asObservable() ?? .empty()
            }
            .subscribe(onNext: { [weak self] data in
                self?.currentWeatherRelay.accept(data)
            }, onError: {error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        input.loadCurrentWeather
            .flatMapLatest { [weak self] in
                self?.repository.fetchForecastWeatherData()
                    .asObservable() ?? .empty()
            }.subscribe(onNext: { [weak self] data in
                self?.forecastWeatherRelay.accept(data)
                
            }, onError: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
                                 
                         
            
        return Output(currentWeather: currentWeatherRelay, forecastWeatherResult: forecastWeatherRelay)
            }
        
    
    

    
    
    
    
    struct Input {
        let loadCurrentWeather: Observable<Void>
        
    }
    
    struct Output {
        let currentWeather: BehaviorRelay<CurrentWeatherResult?>
        let forecastWeatherResult: BehaviorRelay<ForecastWeatherResult?>
    }
    
}
