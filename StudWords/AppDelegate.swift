//
//  AppDelegate.swift
//  StudWords
//
//  Created by Vitaliy Griza on 28.09.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        coordinator = Coordinator(navigationController: NavigationVC())

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator?.rootViewController
        window?.makeKeyAndVisible()

        coordinator?.start()

        return true
    }
}

