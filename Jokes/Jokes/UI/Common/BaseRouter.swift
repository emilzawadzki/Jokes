//
//  BaseRouter.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import UIKit

class BaseRouter: NSObject {
	
	func navigationController() -> UINavigationController? {
		if let delegate = UIApplication.shared.delegate as? AppDelegate {
			return navigationControllerFromWindow(window: delegate.window)
		}
		return nil
	}
	
	func navigationControllerFromWindow(window: UIWindow?) -> UINavigationController? {
		var navVC = window?.rootViewController as? UINavigationController
		var modalVC : UIViewController? = navVC
		while modalVC?.presentedViewController != nil {
			modalVC = modalVC?.presentedViewController
			if modalVC is UINavigationController {
				navVC = modalVC as? UINavigationController
			}
		}
		return navVC
	}
}
