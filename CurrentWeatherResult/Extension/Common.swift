//
//  Extension+.swift
//  CurrentWeatherResult
//
//  Created by KimRin on 11/12/24.
//

import UIKit

protocol CellReUsable {
    static var id: String { get }
}

extension CellReUsable {
    static var id: String {
        String(describing: Self.self)
    }
}
