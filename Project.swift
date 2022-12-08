import ProjectDescription
import ProjectDescriptionHelpers


// MARK: - Project

let project = Project.app(name: "ReJordIOS",
                          platform: .iOS,
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
                            .external(name: "SwiftyJSON")
                          ])
