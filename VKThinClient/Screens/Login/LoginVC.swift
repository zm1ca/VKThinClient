//
//  LoginVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit


class LoginVC: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        authService = SceneDelegate.shared().authService
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        authService.wakeUpSession()
    }
}
