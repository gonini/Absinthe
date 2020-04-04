//
//  ContainerSetUp.swift
//  Absinthe
//
//  Created by User on 14/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import Foundation
import AbsintheUI
import ViewModel
import Service
import Swinject

extension AppDelegate {
    func createContainer() -> Container {
        let container = Container()
        // Intro
        container.register(IntroViewController.self) { _ in IntroViewController() }

        // Permission
        container.register(PermissionServiceType.self) { _ in PermissionService() }
        container.register(PermissionViewReactor.self) {
            PermissionViewReactor(permissionService: $0.resolve(PermissionServiceType.self)!)
        }
        container.register(PermissionViewController.self) {
            PermissionViewController(reactor: $0.resolve(PermissionViewReactor.self)!)
        }
        return container
    }
}
