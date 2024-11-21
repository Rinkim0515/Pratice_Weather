//
//  selectedCell.swift
//  CurrentWeatherResult
//
//  Created by KimRin on 11/13/24.
//

import UIKit
import SnapKit


class SelectedCell: UICollectionViewCell, CellReUsable {
    let weatherIcon = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "temporary")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let temperature = {
        let label = UILabel()
        label.text = "11.0°C"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        return label
    }()
    let cityName = {
        let label = UILabel()
        label.text = "Seoul"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.backgroundColor = .lightGray
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
        
        weatherIcon.snp.makeConstraints{
            $0.verticalEdges.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().offset(5)
            $0.height.equalToSuperview().inset(5)
            $0.width.equalTo(weatherIcon.snp.height)
        }
        cityName.snp.makeConstraints{
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            
        }
        temperature.snp.makeConstraints{
            $0.top.equalTo(cityName.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            
        }
        
        
    }
    
    func configureCell(){
        
    }
    
    
}




