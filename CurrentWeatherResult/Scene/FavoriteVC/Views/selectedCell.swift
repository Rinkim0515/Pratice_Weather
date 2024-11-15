//
//  selectedCell.swift
//  CurrentWeatherResult
//
//  Created by KimRin on 11/13/24.
//

import UIKit

class SelectedCell: UICollectionViewCell, CellReUsable {
    let weatherIcon = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let temperature = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    let cityName = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [
            weatherIcon,
            temperature,
            cityName
        ].forEach { addSubview($0) }
        
        
    }
    
    func configureCell(){
        
    }
    
    
}
