//
//  FavoriteVC.swift
//  CurrentWeatherResult
//
//  Created by KimRin on 11/12/24.
//

import UIKit

class FavoriteVC: UIViewController {
    let favoriteView = FavoriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.view = favoriteView
        favoriteView.searchTextField.delegate = self
    }
    
}

//MARK: - textField
extension FavoriteVC: UITextFieldDelegate {
    
}

//MARK: - CollectionView
extension FavoriteVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedCell.id, for: indexPath) as! SelectedCell
        
        return cell
    }
    
    
}

//섹션 1 -> 즐겨찾는 날씨
//섹션 2 -> 최근기록 날씨