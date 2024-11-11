//
//  MainView.swift
//  CurrentWeatherResult
//
//  Created by KimRin on 10/27/24.
//

import UIKit
import SnapKit

class MainView: UIView {
    let locationButton = {
        let button = UIButton()
        let image = UIImage(systemName: "location.app.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
     let titleLabel = {
        let lb = UILabel()
        lb.text = "서울 특별시"
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 30)
        return lb
    }()
    
     let tempLabel  = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 50)
        lb.text = "20도"
        return lb
    }()
    
     let tempMinLabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 20)
        lb.text = "222도"
        return lb
    }()
    
     let tempMaxLabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 20)
        lb.text = "20도"
        return lb
    }()
    
    private let tempStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 20
        sv.distribution = .fillEqually
        return sv
    }()
    
     let imageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .black
        return iv
    }()
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        
        self.backgroundColor = .black
        [
            locationButton,
            titleLabel,
            tempLabel,
            tempStackView,
            imageView,
            tableView
        ].forEach{ self.addSubview($0) }
        
        [
            tempMaxLabel,
            tempMinLabel
        ].forEach{ tempStackView.addArrangedSubview($0) }
        
        locationButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(20)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(120)
        }
        tempLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        tempStackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(tempLabel.snp.bottom).offset(10)
        }
        imageView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(160)
            $0.top.equalTo(tempStackView.snp.bottom).offset(20)
        }
        tableView.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(50)
        }
        
    }
}


