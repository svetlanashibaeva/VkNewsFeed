//
//  AuthService.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 21.11.2022.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInDidFail()
}

final class AuthService: NSObject {
    
    private let appId = "51482472"
    private let vkSdk: VKSdk
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    var userId: String? {
        return VKSdk.accessToken()?.userId
    }
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        let scope = ["wall", "friends"]
        VKSdk.wakeUpSession(scope) { [weak self] state, error in
            guard let self = self else { return }
            switch state {
            case .initialized:
                VKSdk.authorize(scope)
            case .authorized:
                self.delegate?.authServiceSignIn()
            default:
                self.delegate?.authServiceSignInDidFail()
            }
        }
    }
}

extension AuthService: VKSdkDelegate {
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authServiceSignIn()
        } 
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authServiceSignInDidFail()
    }
}

extension AuthService: VKSdkUIDelegate {
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
