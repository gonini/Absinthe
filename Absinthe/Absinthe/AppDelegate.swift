//
//  AppDelegate.swift
//  Absinthe
//
//  Created by User on 01/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import UIKit
import AbsintheUI
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    lazy var container: Container = {
        return createContainer()
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = container.resolve(MainViewController.self)
        window?.makeKeyAndVisible()
        return true
    }
}
