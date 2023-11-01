//
//  SceneDelegate.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit
import FirebaseAuth
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        (UIApplication.shared.delegate as? AppDelegate)?.window = window
        window = UIWindow(windowScene: windowScene)
        if OnBoardServices.shared.isOnBoard() {
            if Auth.auth().currentUser != nil {
                gotoMain()
            } else {
                gotoScreenSelected()
            }
        }else {
            gotoOnBoard()
        }
    }
    private func gotoOnBoard() {
        let gotoOnBoard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "OnBoardViewController")
        let onBoardNav = UINavigationController(rootViewController: gotoOnBoard)
        window?.rootViewController = onBoardNav
        window?.makeKeyAndVisible()
    }
    private func gotoScreenSelected() {
        let gotoScreenSelected = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ScreenSelectedViewController")
        let screenSelectedNav = UINavigationController(rootViewController: gotoScreenSelected)
        window?.rootViewController = screenSelectedNav
        window?.makeKeyAndVisible()
    }
    private func gotoLogin() {
        let gotoLogin = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginSegmentedViewController")
        let loginNav = UINavigationController(rootViewController: gotoLogin)
        window?.rootViewController = loginNav
        window?.makeKeyAndVisible()
    }
    private func gotoMain() {
        let gotoMain = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController")
        let mainVc = UINavigationController(rootViewController: gotoMain)
        window?.rootViewController = mainVc
        window?.makeKeyAndVisible()
    }


}

