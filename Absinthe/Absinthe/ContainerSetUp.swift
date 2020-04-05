//
//  ContainerSetUp.swift
//  Absinthe
//
//  Created by User on 14/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import Foundation
import Swinject
import AbsintheUI
import Service
import ViewModel

extension AppDelegate {
    func createContainer() -> Container {
        let container = Container()

        container.register(Presenter.self) { _ in
            return Presenter(container: container)
        }.inObjectScope(.container)

        container.register(PermissionServiceType.self) { _ in PermissionService() }

        // Intro
        container.register(IntroViewReactor.self) {
            IntroViewReactor(
                requiredPermissions: AbsinthePolicy.requiredPermissions,
                permissionService: $0.resolve(PermissionServiceType.self)!,
                presenter: $0.resolve(Presenter.self)!
            )
        }
        container.register(IntroViewController.self) {
            IntroViewController(reactor: $0.resolve(IntroViewReactor.self)!)
        }

        // Permission
        container.register(PermissionViewReactor.self) {
            PermissionViewReactor(
                requiredPermissions: AbsinthePolicy.requiredPermissions,
                permissionService: $0.resolve(PermissionServiceType.self)!,
                presenter: $0.resolve(Presenter.self)!
            )
        }
        container.register(PermissionViewController.self) {
            PermissionViewController(reactor: $0.resolve(PermissionViewReactor.self)!)
        }

        // Gallery
        container.register(GalleryViewReactor.self) { _ in
            GalleryViewReactor()
        }

        container.register(GalleryViewController.self) {
            GalleryViewController(reactor: $0.resolve(GalleryViewReactor.self)!)
        }
        return container
    }
}
