//
//  AppDelegate.swift
//  CurrentWeatherResult
//
//  Created by bloom on 7/10/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds) //핸드폰을 가득채운 크기
        
        window.rootViewController = UINavigationController(rootViewController: MainVC())
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }



}

