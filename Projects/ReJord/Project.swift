import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

private let projectName = "ReJord"
private let targetVersion = "15.0"

let project = Project.app(
  name: projectName,
  platform: .iOS,
  iOSTargetVersion: targetVersion,
  dependencies: [
    .rxSwift,
    .rxFlow,
    .reactorKit,
    .kingFisher,
    .moya,
    .rxMoya,
    .alamofire,
    .snapKit,
    .then,
    .parchment,
    TargetDependency.Project.ReJordUI
  ]
)
