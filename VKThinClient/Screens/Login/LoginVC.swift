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
        authService = SceneDelegate.shared().authService
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAuthPendingLabel()
        authService.wakeUpSession()
    }
    
    private func showAuthPendingLabel() {
        self.authPendingLabel.alpha = 1
        UIView.transition(with: authPendingLabel, duration: 1, options: [.curveEaseIn, .repeat, .autoreverse]) {
            self.authPendingLabel.alpha = 0
        }
    }
}
