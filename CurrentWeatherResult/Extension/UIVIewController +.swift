//
//  UIVIewController +.swift
//  CurrentWeatherResult
//
//  Created by KimRin on 10/28/24.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewWillAppear: Observable<Void> {
        return methodInvoked(#selector(Base.viewWillAppear(_:)))
            .map { _ in}
    }
    
}
