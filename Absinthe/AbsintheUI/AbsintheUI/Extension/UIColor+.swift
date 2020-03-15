//
//  UIImage+.swift
//  AbsintheUI
//
//  Created by User on 15/03/2020.
//  Copyright © 2020 gonisoft. All rights reserved.
//

import UIKit

extension UIColor {
    var image: UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        defer { UIGraphicsEndImageContext() }
        UIGraphicsBeginImageContext(rect.size)
        guard let cgContext = UIGraphicsGetCurrentContext() else {
            assertionFailure()
            return UIImage()
        }
        cgContext.setFillColor(cgColor)
        cgContext.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            assertionFailure()
            return UIImage()
        }
        return image
    }
}
