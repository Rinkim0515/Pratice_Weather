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
        return textField
    }()
    // 검색실패시 -> 도시가 없음을 alert로 보여줌, 검색기록에 띄우지 않음
    let favoriteColletctionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let recentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 화면에서 collectionView로 최근리스트 5개와 즐겨찾기 리스트 섹션 2개로 구성
}
