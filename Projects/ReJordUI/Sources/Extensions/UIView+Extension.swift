//
//  UIViewExtension.swift
//  ReJordUI
//
//  Created by 송하민 on 2022/12/11.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
  
  public enum SnpType {
    case make
    case remake
    case update
  }
  
  public func setComponent(baseView: UIView, snpConstraints: @escaping (_ make: ConstraintMaker) -> Void, snpType: SnpType = .make) {
    baseView.addSubview(self)
    switch snpType {
    case .make:
      self.snp.makeConstraints(snpConstraints)
    case .remake:
      self.snp.remakeConstraints(snpConstraints)
    case .update:
      self.snp.updateConstraints(snpConstraints)
    }
    
  }
}
