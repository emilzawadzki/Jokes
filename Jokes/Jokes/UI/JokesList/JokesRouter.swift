//
//  JokesRouter.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import Foundation
import UIKit

class JokesRouter: BaseRouter {

	func getMainView() -> UIViewController? {
		
		let storyboard = UIStoryboard(name: "Main", bundle: .main)
		if let jokesVC = storyboard.instantiateInitialViewController() as? JokesVC {
			
			jokesVC.presenter = JokesPresenter(view: jokesVC, router: self)
			
			return UINavigationController(rootViewController: jokesVC)
		}
		return nil
	}
	
	
}
