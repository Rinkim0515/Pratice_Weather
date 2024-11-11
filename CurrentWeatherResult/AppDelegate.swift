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
        
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = .white
        let firstVC = UINavigationController(rootViewController: MainVC())
        let secondVC = UINavigationController(rootViewController: FavoriteVC())
        
        tabBarController.setViewControllers([firstVC, secondVC], animated: true)
        
        if let items = tabBarController.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "star")
            items[0].image = UIImage(systemName: "star.fill")
            items[0].title = "현재날씨"
            
            items[1].selectedImage = UIImage(systemName: "star")
            items[1].image = UIImage(systemName: "star.fill")
            items[1].title = "즐겨찾기"
        }
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        self.window = window
        return true
    }



}

