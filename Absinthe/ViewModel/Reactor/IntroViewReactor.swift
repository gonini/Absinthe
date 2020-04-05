//
//  IntroViewReactor.swift
//  ViewModel
//
//  Created by User on 29/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

public final class IntroViewReactor: Reactor {
    public var initialState = State()

    public enum Action {
        case checkPermission
    }

    public enum Mutation {}

    public struct State {}

    private let requiredPermissions: [PermissionType]
    private let permissionService: PermissionServiceType
    private let presenter: PresenterType

    public init(
        requiredPermissions: [PermissionType],
        permissionService: PermissionServiceType,
        presenter: PresenterType
    ) {
        self.requiredPermissions = requiredPermissions
        self.permissionService = permissionService
        self.presenter = presenter
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .checkPermission:
                return permissionService.hasPermissions(types: requiredPermissions)
                    .do(onSuccess: { [weak presenter] hasPermission in
                        let scene: Scene = hasPermission ? .gallery : .permission
                        presenter?.present(scene: scene)
                    })
                    .asObservable()
                    .flatMap { _ in Observable<Mutation>.empty() }
        }
    }
}
