//
//  Dependency+Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 송하민 on 2022/12/10.
//

import ProjectDescription

extension TargetDependency {
  public enum Project {}
}

extension TargetDependency.Project {
  public static let ReJordUI = TargetDependency.project(
    target: "ReJordUI",
    path: .relativeToRoot("Projects/ReJordUI")
  )
}


