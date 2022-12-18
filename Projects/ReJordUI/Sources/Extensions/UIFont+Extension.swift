//
//  FontExtensions.swift
//  ReJordUITests
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit

extension UIFont {
  public enum RobotoType: String {
    case light
    case lightItalic
    case medium
    case mediumItalic
    case regular
    case thin
    case thinItalic
    case bold
    case boldItalic
  }
  
  public static func roboto(fontType: RobotoType, fontSize: CGFloat) -> UIFont {
    var usableRobotoFont: UIFont?
    switch fontType {
    case .light:
      usableRobotoFont = UIFont(font: ReJordUIFontFamily.Roboto.light, size: fontSize)
    case .lightItalic:
      usableRobotoFont = UIFont(font: ReJordUIFontFamily.Roboto.lightItalic, size: fontSize)
    case .medium:
      usableRobotoFont = UIFont(font: ReJordUIFontFamily.Roboto.medium, size: fontSize)
    case .mediumItalic:
      usableRobotoFont = UIFont(font: ReJordUIFontFamily.Roboto.mediumItalic, size: fontSize)
    case .regular:
      usableRobotoFont = UIFont(font: ReJordUIFontFamily.Roboto.regular, size: fontSize)
    case .thin:
      usableRobotoFont = UIFont(font: ReJordUIFontFamily.Roboto.thin, size: fontSize)
    case .thinItalic:
      usableRobotoFont = UIFont(font: ReJordUIFontFamily.Roboto.thinItalic, size: fontSize)
    case .bold:
      usableRobotoFont = UIFont(font: ReJordUIFontFamily.Roboto.bold, size: fontSize)
    case .boldItalic:
      usableRobotoFont = UIFont(font: ReJordUIFontFamily.Roboto.boldItalic, size: fontSize)
    }
    
    guard let usableFont = usableRobotoFont else {
      print(ReJordUIStrings.waringFontMissing)
      return UIFont(name: "AppleSDGothicNeo-medium", size: fontSize)!
    }
    return usableFont
  }
}

