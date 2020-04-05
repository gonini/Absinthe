//
//  PermissionService.swift
//  Service
//
//  Created by User on 16/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import Photos
import UserNotifications
import RxSwift
import ViewModel

public final class PermissionService: PermissionServiceType {
    public init() { }

    public func requestPermissionIfNeeded(for permission: PermissionType) -> Single<AuthorizationStatus> {
        switch permission {
        case .photo:
            return requestPhotoPermission()
        case .notification:
            return requestNotificationPermission()
        }
    }

    public func hasPermissions(types: [PermissionType]) -> Single<Bool> {
        return Observable.from(types)
            .compactMap { [weak self] type -> Single<Bool> in
                guard let ss = self else { return .just(false) }
                switch type {
                case .photo:
                    return .just(PHPhotoLibrary.authorizationStatus() == .authorized)
                case .notification:
                    return ss.getUNAuthorizationStatus().map { $0 == .authorized }
                }
            }
            .toArray()
            .flatMap { Single.zip($0) }
            .map { grantedList in grantedList.allSatisfy { $0 } }
    }

    private func requestPhotoPermission() -> Single<AuthorizationStatus> {
        return .create { resolve -> Disposable in
            let status = PHPhotoLibrary.authorizationStatus()

            guard status == .notDetermined else {
                resolve(.success(AuthorizationStatus(phAuthStatus: status)))
                return Disposables.create()
            }

            PHPhotoLibrary.requestAuthorization {
                resolve(.success(AuthorizationStatus(phAuthStatus: $0) ))
            }
            return Disposables.create()
        }
    }

    private func requestNotificationPermission() -> Single<AuthorizationStatus> {
        return .create { [weak self] resolve -> Disposable in
            guard let ss = self else {
                return Disposables.create()
            }
            return ss.getUNAuthorizationStatus()
                .subscribe(onSuccess: { status in
                    guard status == .notDetermined else {
                        resolve(.success(AuthorizationStatus(notifiAuthStatus: status)))
                        return
                    }

                    UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert]) { (granted, error) in
                        guard error == nil else {
                            // 추후 로깅합시다..
                            assertionFailure()
                            return
                        }

                        if granted {
                            resolve(.success(AuthorizationStatus(notifiAuthStatus: .authorized)))
                        } else {
                            resolve(.success(AuthorizationStatus(notifiAuthStatus: .denied)))
                        }
                    }
                })
        }
    }

    private func getUNAuthorizationStatus() -> Single<UNAuthorizationStatus> {
        return .create { resolve -> Disposable in
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                resolve(.success(settings.authorizationStatus))
            }
            return Disposables.create()
        }
    }
}

extension AuthorizationStatus {
    init(phAuthStatus: PHAuthorizationStatus) {
        switch phAuthStatus {
        case .authorized:
            self = .authorized
        case .restricted,
             .denied:
            self = .denied
        default:
            assertionFailure()
            self = .denied
        }
    }

    init(notifiAuthStatus: UNAuthorizationStatus) {
        switch notifiAuthStatus {
        case .authorized,
             .provisional:
            self = .authorized
        case .denied:
            self = .denied
        default:
            assertionFailure()
            self = .denied
        }
    }
}
