//
//  FavoriteVM.swift
//  CurrentWeatherResult
//
//  Created by KimRin on 11/12/24.
//

import Foundation
import RxSwift

class FavoriteVM {
    // 여기서는 도시 이름기반으로 검색하는 로직,
    // 즐겨찾기 한 리스트들의 저장, 및 최근검색도시의 리스트를 coredata로 저장
    // coredata의 저장한것들을 호출해오는것, 및 중복 방지 set으로 호출
    //
    func transform(input: Input) -> Output {
        .init()
    }
    
    struct Input {
        let searchCity: Observable<String>
        let saveCity:  Observable<String>
    }
    
    struct Output {
        
    }
}
