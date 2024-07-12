//
//  ViewController.swift
//  CurrentWeatherResult
//
//  Created by bloom on 7/10/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let urlQueryItem: [URLQueryItem] = [
        URLQueryItem(name: "lat", value: "37.5"),
        URLQueryItem(name: "lon", value: "126.9"),
        URLQueryItem(name: "appid", value: "4b4ab08dfbebc4502aa246da27e874e4"),
        URLQueryItem(name: "units", value: "metric")
    ]
    private let titleLabel = {
        let lb = UILabel()
        lb.text = "서울 특별시"
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 30)
        return lb
    }()
    private let tempLabel  = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 50)
        lb.text = "20도"
        return lb
    }()
    private let tempMinLabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 20)
        lb.text = "20도"
        return lb
        
    }()
    private let tempMaxLabel = {
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
    private let imageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .black
        return iv
    }()
    private lazy var tableView = {
        let tv = UITableView()
        tv.backgroundColor = .black
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchCurrentWeatherData()
    }
    
    private func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void){
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) {data, response, error in
            guard let data, error == nil else{
                print("failure")
                completion(nil)
                return
            }
            // http status code success range is 200~300
            let successRange = 200..<300
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
                    print("JSon Decoding fail")
                    completion(nil)
                    return
                }
                completion(decodedData)
            } else{
                print("응답오류")
                completion(nil)
            }
        }.resume()
        
        
    }
    private func fetchCurrentWeatherData(){
        var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
        urlComponents?.queryItems = self.urlQueryItem
        
        guard let url = urlComponents?.url else {
            print("잘못된 URL")
            return
        }
        
        fetchData(url: url){ [weak self] (result: CurrentWeatherResult?) in
            guard let self, let result else { return }
            //ui 작업은 main Thread에서
            DispatchQueue.main.async{ // 동기 비동기 때 배운다함
                self.tempLabel.text = "\(Int(result.main.temp))°C"
                self.tempMaxLabel.text = "최고: \(Int(result.main.tempMax))°C"
                self.tempMinLabel.text = "최저: \(Int(result.main.tempMin))°C"
            }
            
            guard let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(result.weather[0].icon)@2x.png") else{
                return
            }
            
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async{
                        self.imageView.image = image
                    }
                    
                }
            }
                    
        }
        
    }
    private func configureUI(){
        view.backgroundColor = .black
        [
            titleLabel,
            tempLabel,
            tempStackView,
            imageView
        ].forEach{ view.addSubview($0) }
        
        [
            tempMaxLabel,
            tempMinLabel
        ].forEach{ tempStackView.addArrangedSubview($0) }
        
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
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        <#code#>
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
