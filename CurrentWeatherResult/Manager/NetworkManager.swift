//
//  NetworkManager.swift
//  CurrentWeatherResult
//
//  Created by KimRin on 10/27/24.
//

import Foundation
import RxSwift

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    
    
    func fetch<T:Decodable>(url: URL) -> Single<T> {
        return Single.create { single in
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    single(.failure(error))
                    return
                }
                
                guard let data = data else {
                    single(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    single(.success(decodedData))
                } catch let decodingError {
                    single(.failure(decodingError))
                }
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
    
    
    func fetchData<T: Decodable>(url: URL, completion: @escaping (T?) -> Void){
        let session = URLSession(configuration: .default)
        session.dataTask(with: URLRequest(url: url)) {data, response, error in
            guard let data, error == nil else{
                print("failure")
                completion(nil)
                return
            }
            
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
    
    
}
