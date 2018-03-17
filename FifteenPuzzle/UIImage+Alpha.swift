//
//  UIImage+Alpha.swift
//  FifteenPuzzle
//
//  Created by Colin St. Claire on 2/22/18.
//  Copyright © 2018 Colin. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  func alpha(_ value:CGFloat) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
}
}
