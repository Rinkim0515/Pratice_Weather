//
//  FavoriteView.swift
//  CurrentWeatherResult
//
//  Created by KimRin on 11/12/24.
//

import UIKit
import SnapKit

class FavoriteView: UIView {
    // 검색하기 서치 버튼 누르거나 엔터 누르면 -> 모달로 띄워주고
    // 화면에 업데이트 띄워줌 -> 메인쓰레드 모달 아웃시에
    // 어떤것을 보여주냐 , 아이콘
    // 코어데이터로 값을 가지고 있음 5개 정도
    // 하나의 구조체에 보여줘야할 데이터 -> 아이콘주소,최근날씨,도시이름,강수량
    //
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search City"
        textField.backgroundColor = .systemGray3
        textField.borderStyle = .roundedRect
        return textField
    }()
    // 검색실패시 -> 도시가 없음을 alert로 보여줌, 검색기록에 띄우지 않음
    //여기 그 과제중에 있음 section나눠서 하는거 그거 기반으로 만들고
    let recentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout() {
        [
            searchTextField
        ].forEach{ addSubview($0) }
        
        searchTextField.snp.makeConstraints{
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide.snp.horizontalEdges).inset(20)
            $0.height.equalTo(30)
            
        }
    }
    // 화면에서 collectionView로 최근리스트 5개와 즐겨찾기 리스트 섹션 2개로 구성
}
