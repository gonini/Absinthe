//
//  IntroViewReactor.swift
//  ViewModel
//
//  Created by User on 29/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import Foundation
import Service
import ReactorKit
import RxSwift

public final class IntroViewReactor: Reactor {
    public var initialState: State

    public enum Event {
        case goToPermission
        case goToMain
    }

    public enum Action {
        case checkPermission
    }

    public enum Mutation {}

    public struct State {}

    public var event: Observable<Event> {
        return eventSubject.asObservable()
    }

    private let eventSubject = PublishSubject<Event>()

    private let permissionService: PermissionServiceType

    public init(permissionService: PermissionServiceType) {
        initialState = State()
        self.permissionService = permissionService
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
            case .checkPermission:
                return permissionService.hasPermission(types: PermissionType.requiredPermissions)
                    .do(onSuccess: { [weak eventSubject] hasPermission in
                        let event: Event = hasPermission ? .goToMain : .goToPermission
                        eventSubject?.onNext(event)
                    })
                    .asObservable()
                    .flatMap { _ in Observable<Mutation>.empty() }
        }
    }
}
