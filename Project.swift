import ProjectDescription
import ProjectDescriptionHelpers


// MARK: - Project

let project = Project.app(name: "ReJordIOS",
                          platform: .iOS,
                          additionalTargets: [],
                          dependencies: [
                            .external(name: "RxSwift"),
                            .external(name: "SnapKit")
                          ])
