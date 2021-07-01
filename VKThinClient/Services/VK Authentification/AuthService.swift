//
//  AuthService.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 28.06.21.
//

import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
    func authServiceLogout()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appID = "7890249"
    private let vkSdk: VKSdk
    var token: String?  { VKSdk.accessToken().accessToken }
    var userId: String? { VKSdk.accessToken()?.userId }
    weak var delegate: AuthServiceDelegate?
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["offline", "wall", "friends", "status"]
        VKSdk.wakeUpSession(scope) { [delegate] state, error in
            switch state {
            case .initialized: VKSdk.authorize(scope)
            case .authorized:  delegate?.authServiceSignIn()
            default:           delegate?.authServiceSignInDidFail()
            }
        }
    }
    
    func vkLogout() {
        VKSdk.forceLogout()
        delegate?.authServiceLogout()
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        guard result.token != nil else { return }
        delegate?.authServiceSignIn()
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authServiceSignInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) { }
}
