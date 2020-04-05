//
//  PermissionType.swift
//  ViewModel
//
//  Created by User on 04/04/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import Foundation

public enum PermissionType {
    case photo
    case notification
}

public extension PermissionType {
    static var requiredPermissions: [PermissionType] {
        return [.notification, .photo]
    }
}
