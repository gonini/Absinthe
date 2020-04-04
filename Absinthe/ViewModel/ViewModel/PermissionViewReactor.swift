//
//  PermissionReactor.swift
//  ViewModel
//
//  Created by User on 16/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import Foundation
import Service
import ReactorKit
import RxSwift

public final class PermissionViewReactor: Reactor {
    public var initialState: State

    public enum Event {
        case goToSetting(DeniedPermissionType)
        case goToMain
    }

    public enum Action {
        case tapContinue
    }

    public enum Mutation {
    }

    public struct State {
    }

    public var event: Observable<Event> {
        return eventSubject.asObservable()
    }

    private let eventSubject = PublishSubject<Event>()

    private let permissionService: PermissionServiceType

    public init(permissionService: PermissionServiceType) {
        self.permissionService = permissionService
        initialState = State()
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {

        case .tapContinue:
            return permissionService.hasPermission(types: PermissionType.requiredPermissions)
                .asObservable()
                .flatMap { [weak self] hasPermission -> Observable<Mutation> in
                    guard let ss = self else { return .empty() }
                    if hasPermission {
                        ss.eventSubject.onNext(.goToMain)
                        return .empty()
                    }
                    return ss.requestPermissionIfNeeded(permissions: PermissionType.requiredPermissions)
                }
        }
    }

    private func requestPermissionIfNeeded(permissions: [PermissionType]) -> Observable<Mutation> {
        return Observable.from(permissions)
            .concatMap { [weak permissionService] permissionType -> Observable<(AuthorizationStatus, PermissionType)> in
                guard let permissionService = permissionService else {
                    return .never()
                }
                return permissionService.requestPermissionIfNeeded(for: permissionType)
                    .observeOn(MainScheduler.instance)
                    .map { ($0, permissionType) }
                    .asObservable()
            }
            .concatMap { [weak eventSubject] (status, permissionType) -> Observable<Mutation> in
                switch status {
                case .authorized:
                    return .empty()
                case .denied:
                    let deniedPermission = DeniedPermissionType(permissionType: permissionType)
                    eventSubject?.onNext(.goToSetting(deniedPermission))
                    return .never()
                }
            }
    }
}

public enum DeniedPermissionType {
    case photo
    case notification
}

private extension DeniedPermissionType {
    init(permissionType: PermissionType) {
        switch permissionType {
        case .photo:
            self = .photo
        case .notification:
            self = .notification
        }
    }
}

