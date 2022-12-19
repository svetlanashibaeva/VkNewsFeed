//
//  AuthViewController.swift
//  VkNewsFeed
//
//  Created by Света Шибаева on 21.11.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private let authService = SceneDelegate.shared().authService

    @IBAction func signInTouch(_ sender: UIButton) {
        authService?.wakeUpSession()
    }
}

