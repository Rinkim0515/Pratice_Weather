//
//  ViewController.swift
//  CurrentWeatherResult
//
//  Created by bloom on 7/10/24.
// 어떤기능을 넣을것인가?
/*
 일단 - 현재위치를 받아서 온도를 가져오는것 ->
 우산챙기미 -> 비올 확률 이 50프로가 넘어간다 -> notification
 위치는 로컬로 받아옴 -> 허가 필요
 검색기능 -> 도시 검색
 뷰는 총 3개
 현재 위치의 날씨와 검색할도시의 위치 , 즐겨찾기 기능 , 마지막은 테이블뷰로 구현한 로그인기능 ?
 
 로그인으로 써 뭘하고싶은것인가?
 친구맺기-> 알림주기?
 
 */

import UIKit
import SnapKit
import CoreLocation
import RxSwift

class MainVC: UIViewController {
    
    private let urlQueryItem: [URLQueryItem] = [
        URLQueryItem(name: "lat", value: "37.5"),
        URLQueryItem(name: "lon", value: "126.9"),
        URLQueryItem(name: "appid", value: "4b4ab08dfbebc4502aa246da27e874e4"),
        URLQueryItem(name: "units", value: "metric")
    ]
    
    private let mainView = MainView()
    
    private var dataSource = [ForecastWeather]()
    
    private let disposedBag = DisposeBag()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        setupUI()
        
        fetchCurrentWeatherData()
        fetchForecastData()
    }
    
    private func setupUI() {
        self.view = mainView
    }
    
    private func fetchCurrentWeatherData(){
        var urlComponents = URLComponents(string: "\(K.API.baseURL)weather")
        urlComponents?.queryItems = self.urlQueryItem
        
        guard let url = urlComponents?.url else {
            print("잘못된 URL")
            return
        }
        
        NetworkManager.shared.fetchData(url: url){ [weak self] (result: CurrentWeatherResult?) in
            guard let self, let result else { return }
            //ui 작업은 main Thread에서
            DispatchQueue.main.async{ // 동기 비동기 때 배운다함
                self.mainView.tempLabel.text = "\(Int(result.main.temp))°C"
                self.mainView.tempMaxLabel.text = "최고: \(Int(result.main.tempMax))°C"
                self.mainView.tempMinLabel.text = "최저: \(Int(result.main.tempMin))°C"
            }
            
            guard let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(result.weather[0].icon)@2x.png") else{
                return
            }
            
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async{
                        self.mainView.imageView.image = image
                    }
                    
                }
            }
            
        }
        
    }
    
    private func fetchForecastData(){
        var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/forecast?")
        urlComponents?.queryItems = self.urlQueryItem
        
        
        guard let url = urlComponents?.url else{
            print("잘못된 URL")
            return
        }
        NetworkManager.shared.fetchData(url: url){ [weak self] (result: ForecastWeatherResult?) in
            guard let self, let result else { return }
            
            for forecastWeather in result.list{
                print("\(forecastWeather.main)  \(forecastWeather.dtTxt) \n\n")
            }
            
            DispatchQueue.main.async{
                self.dataSource = result.list
                self.mainView.tableView.reloadData()
            }
        }
        
        
    }
    
    
    
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id) as? TableViewCell else { return UITableViewCell() }
        cell.configureCell(forecastWeather: dataSource[indexPath.row])
        return cell
        
    }
}





