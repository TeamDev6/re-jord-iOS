import ProjectDescription
import ProjectDescriptionHelpers

// MARK: Dependency

let dependencies = Dependencies(
  swiftPackageManager: SwiftPackageManagerDependencies(
    [
      .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0"),
      .package(url: "https://github.com/RxSwiftCommunity/RxFlow.git", .branch("main")),
      .package(url: "https://github.com/RxSwiftCommunity/RxDataSources.git", from: "5.0.2"),
      .package(url: "https://github.com/ReactorKit/ReactorKit.git", from: "3.2.0"),
      .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.4.1"),
      .package(url: "https://github.com/naldal/Moya.git", .branch("master")),
      .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.6.4"),
      .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.6.0"),
      .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0"),
      .package(url: "https://github.com/devxoul/Then", from: "3.0.0"),
      .package(url: "https://github.com/rechsteiner/Parchment.git", from: "3.2.0"),
      .package(url: "https://github.com/Quick/Nimble.git", from: "11.2.1"),
      .package(url: "https://github.com/Quick/Quick.git", from: "6.1.0"),
      .remote(url: "https://github.com/firebase/firebase-ios-sdk", requirement: .upToNextMajor(from: "8.14.0"))
    ],
    baseSettings: Settings.settings(
      configurations: [
        .debug(name: "Debug"),
        .debug(name: "Development"),
        .debug(name: "Alpha"),
        .release(name: "Release")
      ])
  ),
  platforms: [.iOS]
)

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
