//
//  ContainerSetUp.swift
//  Absinthe
//
//  Created by User on 14/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import Foundation
import AbsintheUI
import Swinject

extension AppDelegate {
    func createContainer() -> Container {
        let container = Container()
        container.register(IntroViewController.self) { _ in IntroViewController() }
        return container
    }
}
