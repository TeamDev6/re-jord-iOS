import ProjectDescription

extension Project {
  
  public static func app(name: String, platform: Platform, additionalTargets: [String], dependencies: [TargetDependency]) -> Project {
    
    let bundleId = "com.reJord.bbuyo"
    let projectName = name
    let iOS_target = "15.0"
    
    return Project(name: name,
                   organizationName: "reJordiOS",
                   packages: [
                   ],
                   targets: [
                    Target(name: projectName,
                           platform: .iOS,
                           product: .app,
                           bundleId: bundleId,
                           deploymentTarget: .iOS(targetVersion: iOS_target, devices: .iphone),
                           infoPlist: .default,
                           sources: ["Targets/\(projectName)/Sources/**"],
                           resources: ["Targets/\(projectName)/Resources/**"],
                           scripts: [],
                           dependencies: dependencies
                          )
                   ],
                   schemes: [
                    Scheme(name: "\(projectName)-Debug"),
                    Scheme(name: "\(projectName)-Release"),
                    Scheme(name: "\(projectName)-Alpha"),
                   ],
                   additionalFiles: [],
                   resourceSynthesizers: []
    )
  }
}


