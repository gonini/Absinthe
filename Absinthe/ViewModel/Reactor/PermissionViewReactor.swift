//
//  PermissionReactor.swift
//  ViewModel
//
//  Created by User on 16/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift

public final class PermissionViewReactor: Reactor {
    public var initialState = State()

    public enum Event {
        case goToSetting(deniedPermission: PermissionType)
    }

    public enum Action {
        case tapContinue
    }

    public struct State {
    }

    public var event: Observable<Event> {
        return eventSubject.asObservable()
    }

    private let eventSubject = PublishSubject<Event>()

    private let permissionService: PermissionServiceType
    private let presenter: PresenterType

    public init(
        permissionService: PermissionServiceType,
        presenter: PresenterType
    ) {
        self.permissionService = permissionService
        self.presenter = presenter
    }

    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .tapContinue:
            return presentGallerySceneIfPermissionAuthorized()
                .asObservable()
                .flatMap { [weak self] presented -> Observable<Mutation> in
                    guard let ss = self else { return .empty() }
                    if presented {
                        return .never()
                    } else {
                        return ss.requestPermissionIfNeeded(permissions: PermissionType.requiredPermissions)
                    }
                }
        }
    }

    private func requestPermissionIfNeeded(permissions: [PermissionType]) -> Observable<Mutation> {
        return Observable.from(permissions)
            .concatMap { [weak permissionService] permissionType -> Observable<(AuthorizationStatus, PermissionType)> in
                guard let permissionService = permissionService else {
                    return .empty()
                }
                return permissionService.requestPermissionIfNeeded(for: permissionType)
                    .observeOn(MainScheduler.instance)
                    .map { ($0, permissionType) }
                    .asObservable()
            }
            .concatMap { [weak self] (status, permissionType) -> Observable<Mutation> in
                guard let ss = self else { return .empty() }
                switch status {
                case .authorized:
                    return ss.presentGallerySceneIfPermissionAuthorized()
                        .asObservable()
                        .flatMap { presented -> Observable<Mutation> in
                            return presented ? .never() : .empty()
                        }
                case .denied:
                    ss.eventSubject.onNext(.goToSetting(deniedPermission: permissionType))
                    return .never()
                }
            }
    }

    private func presentGallerySceneIfPermissionAuthorized() -> Single<Bool> {
        return permissionService.hasPermissions(types: PermissionType.requiredPermissions)
            .do(onSuccess: { [weak self] hasAllPermissions in
                if hasAllPermissions {
                    self?.presenter.present(scene: .gallery)
                }
            })
    }
}

