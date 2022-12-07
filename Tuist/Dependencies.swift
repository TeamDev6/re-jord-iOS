import ProjectDescription
import ProjectDescriptionHelpers

// MARK: Dependency

let dependencies = Dependencies(
  swiftPackageManager: [
    .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0"),
    .package(url: "https://github.com/RxSwiftCommunity/RxFlow.git", .branch("main")),
    .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", from: "5.0.2"),
    .package(url: "https://github.com/ReactorKit/ReactorKit.git", from: "3.2.0"),
    .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.4.1"),
    .package(url: "https://github.com/uber/needle.git", from: "0.21.0"),
    .package(url: "https://github.com/Moya/Moya.git", from: "15.0.3"),
    .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.4"),
    .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.6.0"),
    .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0"),
  ],
  platforms: [.iOS]
)


// MARK: TargetDependency

public extension TargetDependency {
  static let rxSwift: TargetDependency = .external(name: "RxSwift")
  static let rxFlow: TargetDependency = .external(name: "RxFlow")
  static let rxDataSources: TargetDependency = .external(name: "RxDataSources")
  static let reactorKit: TargetDependency = .external(name: "ReactorKit")
  static let kingFisher: TargetDependency = .external(name: "Kingfisher")
  static let needle: TargetDependency = .external(name: "needle")
  static let moya: TargetDependency = .external(name: "Moya")
  static let alamofire: TargetDependency = .external(name: "Alamofire")
  static let snapKit: TargetDependency = .external(name: "SnapKit")
  static let swiftyJSON: TargetDependency = .external(name: "SwiftyJSON")
  
}

// MARK: Package

public extension Package {
  static let rxSwift: Package = .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0")
  static let rxFlow: Package = .package(url: "https://github.com/RxSwiftCommunity/RxFlow.git", .branch("main"))
  static let reactorKit: Package = .package(url: "https://github.com/ReactorKit/ReactorKit.git", from: "3.2.0")
  static let kingFisher: Package = .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.4.1")
  static let needle: Package = .package(url: "https://github.com/uber/needle.git", from: "0.21.0")
  static let moya: Package = .package(url: "https://github.com/Moya/Moya.git", from: "15.0.3")
  static let alamofire: Package = .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.4")
  static let snapKit: Package = .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.6.0")
  static let swiftyJSON: Package = .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0")
  static let rxDataSources: Package = .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", from: "5.0.2")
}

// MARK: SourceFile
public extension SourceFilesList {
  static let sources: SourceFilesList = ["../Sources/**"]
  static let tests: SourceFilesList = "Tests/**"
}

// MARK: Resource
public enum ResourceType: String {
  case xibs        = "Sources/**/*.xib"
  case storyboards = "Resources/**/*.storyboard"
  case assets      = "Resources/**"
}
