//
//  UIImage+Extension.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/15.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

extension UIImage {
  
  public static func image(name string: String) -> UIImage {
    return ReJordUIImages(name: string).image
  }
}
