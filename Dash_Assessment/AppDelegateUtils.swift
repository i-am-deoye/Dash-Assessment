//
//  AppDelegateUtils.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit


final class AppDelegateUtils {
   
    
    static func getApp() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    @available(iOS 13.0, *)
    static func getScene() -> SceneDelegate? {
        return UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }

    
    static func getWindow() -> UIWindow? {
        var window : UIWindow!
        
        if #available(iOS 13.0, *) {
            window = getScene()?.window
        } else {
            // Fallback on earlier versions
            window = getApp()?.window
        }
        
        return window
    }
    
    
    static func routePageIfAuthenticated() {
        
        guard let window = getWindow() else { return }
        let controller: UIViewController = HomePage.init()
        window.rootViewController = UINavigationController.init(rootViewController: controller)
        window.makeKeyAndVisible()
    }
}



