//
//  TableViewCell.swift
//  CurrentWeatherResult
//
//  Created by bloom on 7/11/24.
//

import UIKit
import SnapKit

final class TableViewCell: UITableViewCell {
    
    static let id = "TableViewCell"
    
    private let dtTxtLabel = {
        let lb = UILabel()
        lb.backgroundColor = .black
        lb.textColor = .white
        return lb
    }()
    
    private let tempLabel = {
        let lb = UILabel()
        lb.backgroundColor = .black
        lb.textColor = .white
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI(){
        contentView.backgroundColor = .black
        [
            dtTxtLabel,
            tempLabel
        ].forEach { contentView.addSubview($0) }
        
        dtTxtLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        tempLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    public func configureCell(){
        
    }
    
}
