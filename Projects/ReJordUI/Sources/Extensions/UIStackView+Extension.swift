//
//  UIStackView+Extension.swift
//  ReJordUI
//
//  Created by 송하민 on 2023/01/01.
//  Copyright © 2023 team.reJord. All rights reserved.
//

import UIKit

extension UIStackView {
  public func setStackArrangesView(subViews: [UIView]) {
    subViews.forEach { view in
      self.addArrangedSubview(view)
    }
  }
}
