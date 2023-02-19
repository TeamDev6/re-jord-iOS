//
//  SignInFlow.swift
//  ReJord
//
//  Created by 송하민 on 2022/12/31.
//  Copyright © 2022 team.reJord. All rights reserved.
//

import RxFlow
import UIKit

class LoginFlow: Flow {
	
	enum PushTransition {
		case pushToSignInViewController
		case pushToSignUpViewController
		case pushToSignUpCompleteViewControllor(signUpResult: SignUpResult)
		case pushToMainViewController
	}
	
	// MARK: - Private Properties
	
	private let loginReactor: LoginReactor = LoginReactor(repository: LoginRepositoryImplement())
	private let signUpReactor: SignUpReactor = SignUpReactor(repository: SignUpRepositoryImplement(), signUpResult: nil)
	private let homeReactor: HomeReactor = HomeReactor(repository: HomeRepositoryImplemenet())
	
	
	// MARK: - Life Cycle
	
	init() {
		
	}
	
	// MARK: - Root ViewController
	
	var root: Presentable {
		return self.rootViewController
	}
	
	private lazy var rootViewController: UINavigationController = {
		let viewController = UINavigationController()
		return viewController
	}()
	
	// MARK: - Navigations
	
	func navigate(to step: Step) -> FlowContributors {
		guard let step = step as? ReJordSteps else {
			return .none
		}
		switch step {
		case .signInIsRequired:
			return self.push(to: .pushToSignInViewController)
		case .signUpIsRequired:
			return self.push(to: .pushToSignUpViewController)
		case .signUpCompleteSceneIsRequired(let signUpResult):
			return self.push(to: .pushToSignUpCompleteViewControllor(signUpResult: signUpResult))
		case .mainTabsSceneIsRequired:
			return self.push(to: .pushToMainViewController)
		default:
			return .none
		}
	}
	
	private func push(to step: PushTransition) -> FlowContributors {
		switch step {
		case .pushToSignInViewController:
			let loginViewController = LoginViewController(reactor: self.loginReactor)
			self.rootViewController.pushViewController(loginViewController, animated: true)
			return .one(flowContributor: .contribute(withNextPresentable: loginViewController, withNextStepper: self.loginReactor))
		case .pushToSignUpViewController:
			let signUpFlow = SignUpFlow(root: self.rootViewController)
			let signUpViewController = SignUpViewController(reactor: self.signUpReactor)
			self.rootViewController.pushViewController(signUpViewController, animated: true)
			return .one(flowContributor: .contribute(
				withNextPresentable: signUpFlow,
				withNextStepper: self.signUpReactor
			))
			
		case .pushToSignUpCompleteViewControllor(let signUpResult):
			let signUpReactor = SignUpReactor(repository: SignUpRepositoryImplement(), signUpResult: signUpResult)
			let signUpCompleteViewController = SignUpCompleteViewController(reactor: signUpReactor)
			self.rootViewController.pushViewController(signUpCompleteViewController, animated: true)
			return .one(flowContributor: .contribute(withNextPresentable: signUpCompleteViewController, withNextStepper: signUpReactor))
			
		case .pushToMainViewController:
			
			let homeReactor = HomeReactor(repository: HomeRepositoryImplemenet())
			let challengeReactor = ChallengeReactor()
			let settingsReactor = SettingsReactor()
			
			let homeFlow = HomeFlow(reactor: homeReactor)
			let challengeFlow = ChallengeFlow(reactor: challengeReactor)
			let settingsFlow = SettingsFlows(reactor: settingsReactor)
			
			let mainTabbarViewController = UITabBarController()
			mainTabbarViewController.tabBar.backgroundColor = .white
			
			Flows.use(homeFlow, challengeFlow, settingsFlow, when: .ready) { [weak self] (home, challenge, settings) in
				
				
				let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "person.fill"), selectedImage: nil)
				let challengeItem = UITabBarItem(title: "Challenge", image: UIImage(systemName: "person.fill"), selectedImage: nil)
				let settingsItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "person.fill"), selectedImage: nil)
				
				home.tabBarItem = homeItem
				challenge.tabBarItem = challengeItem
				settings.tabBarItem = settingsItem
				
				mainTabbarViewController.setViewControllers([home, challenge, settings], animated: false)
				self?.rootViewController.pushViewController(mainTabbarViewController, animated: false)
			}
			
			return .multiple(flowContributors: [
				.contribute(withNextPresentable: homeFlow, withNextStepper: MainTabbarStepper()),
				.contribute(withNextPresentable: challengeFlow, withNextStepper: OneStepper(withSingleStep: ReJordSteps.challengeTabIsRequired)),
				.contribute(withNextPresentable: settingsFlow, withNextStepper: OneStepper(withSingleStep: ReJordSteps.settingsTabIsRequired)),
			])
			
		}
	}
	
	
	
}
