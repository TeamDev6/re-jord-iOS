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
  }
  
  public func snpLayout(baseView: UIView, snpType: SnpType = .make, snpConstraints: @escaping (_ make: ConstraintMaker) -> Void) {
    DispatchQueue.main.async {
      baseView.addSubview(self)
      switch snpType {
      case .make:
        self.snp.makeConstraints(snpConstraints)
      case .remake:
        self.snp.remakeConstraints(snpConstraints)
      }
    }
  }
  
  public func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
    let border = UIView()
    self.bringSubviewToFront(border)
    border.backgroundColor = color
    switch edge {
    case .top:
      border.snpLayout(baseView: self) { make in
        make.top.leading.trailing.equalToSuperview()
        make.height.equalTo(thickness)
      }
    case .bottom:
      border.snpLayout(baseView: self) { make in
        make.bottom.leading.trailing.equalToSuperview()
        make.height.equalTo(thickness)
      }
    case .left:
      border.snpLayout(baseView: self) { make in
        make.top.leading.bottom.equalToSuperview()
        make.width.equalTo(thickness)
      }
    case .right:
      border.snpLayout(baseView: self) { make in
        make.top.trailing.bottom.equalToSuperview()
        make.width.equalTo(thickness)
      }
    default:
      break
    }
  }
  
}
