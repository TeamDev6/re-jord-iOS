//
//  FontExtensions.swift
//  ReJordUITests
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

extension UIFont {
  public enum Roboto: String {
    case light = "Light"
    case lightItalic = "LightItalic"
    case medium = "Medium"
    case mediumItalic = "MediumItalic"
    case regular = "Regular"
    case thin = "Thin"
    case thinItalic = "ThinItalic"
  }
  
  public static func roboto(font: Roboto, fontSize: CGFloat) -> UIFont {
    let robotoBase = "Roboto-"
    print("debug ~> \(robotoBase + font.rawValue), size ~> \(fontSize)")
//    return UIFont(name: "Roboto-Medium", size: fontSize)!
    return UIFont(name: "AppleSDGothicNeo-medium", size: fontSize)!
  }
  
}

