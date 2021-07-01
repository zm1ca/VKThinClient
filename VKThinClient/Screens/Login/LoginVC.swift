//
//  LoginVC.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import UIKit


class LoginVC: UIViewController {
    
    private var authService: AuthService!
    @IBOutlet weak var authPendingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authPendingLabel.alpha = 0
        UIView.transition(with: authPendingLabel, duration: 1, options: [.curveLinear]) {
            self.authPendingLabel.alpha = 1
        }

        authService = SceneDelegate.shared().authService
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        authService.wakeUpSession()
    }
}
