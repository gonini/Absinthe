//
//  ViewModelExtension.swift
//  AbsintheUI
//
//  Created by User on 21/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import Foundation
import ViewModel

extension DeniedPermissionType {
    var name: String {
        switch self {
        case .notification:
            return L10n.Permission.Item.Notification.name
        case .photo:
            return L10n.Permission.Item.Picture.name
        }
    }
}
