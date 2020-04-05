//
//  Presenter.swift
//  Absinthe
//
//  Created by User on 04/04/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import UIKit
import Swinject
import AbsintheUI
import Service
import ViewModel

class Presenter: PresenterType {
    private let container: Container

    weak var rootViewController: UIViewController? = nil

    init(container: Container) {
        self.container = container
    }

    func present(scene: Scene) {
        DispatchQueue.main.async { [unowned self] in
            let topPresentViewController = self.getTopMostViewController()

            switch scene {
            case .gallery:
                let galleryVC = self.container.resolve(GalleryViewController.self)!
                galleryVC.modalPresentationStyle = .fullScreen
                topPresentViewController.present(galleryVC, animated: true)

            case .permission:
                let premissionVC = self.container.resolve(PermissionViewController.self)!
                premissionVC.modalPresentationStyle = .fullScreen
                topPresentViewController.present(premissionVC, animated: true)
            }
        }
    }

    private func getTopMostViewController() -> UIViewController {
        guard let rootViewController = rootViewController else {
            preconditionFailure("rootViewController는 nil일 수 없습니다. 반드시 AppDelegate에서 주입하십시오.")
        }
        var viewController = rootViewController
        while let presented = viewController.presentedViewController {
            viewController = presented
        }
        return viewController
    }
}

