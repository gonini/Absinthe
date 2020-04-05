//
//  PermissionServiceType.swift
//  ViewModel
//
//  Created by User on 04/04/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import Foundation
import RxSwift

public protocol PermissionServiceType: class {
    func requestPermissionIfNeeded(for permission: PermissionType) -> Single<AuthorizationStatus>
    func hasPermissions(types: [PermissionType]) -> Single<Bool>
}
