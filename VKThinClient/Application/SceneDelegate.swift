//
//  SceneDelegate.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit
import VK_ios_sdk

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var authService: AuthService!
    
    static func shared() -> SceneDelegate {
        let scene = UIApplication.shared.connectedScenes.first
        return scene?.delegate as! SceneDelegate
    }


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        authService = AuthService()
        authService.delegate = self
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        }
    }
}


extension SceneDelegate: AuthServiceDelegate {
    func authServiceLogout() {
        let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        window?.rootViewController = loginVC
    }
    
    func authServiceShouldShow(viewController: UIViewController) {
        window?.rootViewController?.present(viewController, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        let navigationVC = UIStoryboard(name: "Tabbar", bundle: nil).instantiateViewController(identifier: "navigationVC")
        window?.rootViewController = navigationVC
    }
    
    func authServiceSignInDidFail() {
        print(#function)
    }
}
