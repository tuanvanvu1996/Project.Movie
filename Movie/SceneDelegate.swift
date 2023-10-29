//
//  SceneDelegate.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        (UIApplication.shared.delegate as? AppDelegate)?.window = window
//        window = UIWindow(windowScene: windowScene)
    }

    private func gotoScreenSelected() {
        let gotoScreenSelected = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ScreenSelectedViewController")
        window?.rootViewController = gotoScreenSelected
        window?.makeKeyAndVisible()
    }


}

