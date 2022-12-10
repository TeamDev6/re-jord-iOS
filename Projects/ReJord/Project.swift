import ProjectDescription
import ProjectDescriptionHelpers


// MARK: - Project

private let projectName = "ReJord"
private let targetVersion = "15.0"

let project = Project.app(
  name: projectName,
  platform: .iOS,
  iOSTargetVersion: targetVersion,
  additionalTargets: [],
  dependencies: [
    .external(name: "RxSwift"),
    .external(name: "RxFlow"),
    .external(name: "RxDataSources"),
    .external(name: "ReactorKit"),
    .external(name: "Kingfisher"),
    .external(name: "NeedleFoundation"),
    .external(name: "Moya"),
    .external(name: "Alamofire"),
    .external(name: "SnapKit"),
    .external(name: "SwiftyJSON"),
    .project(target: "ReJordUI", path: .relativeToCurrentFile("../ReJordUI"))
  ]
)
