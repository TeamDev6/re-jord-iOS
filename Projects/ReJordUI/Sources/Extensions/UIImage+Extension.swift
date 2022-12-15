//
//  UIImage+Extension.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/15.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

extension UIImage {
  
  static func image(name string: String) -> UIImage {
    let reJordImage = ReJordUIImages(name: string)
    return UIImage(asset: reJordImage) ?? UIImage()
  }
}
