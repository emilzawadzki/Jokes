//
//  BasePresenter.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import UIKit
import SwiftyJSON

class BasePresenter: NSObject {
	
	func onViewDidLoad() {
		print("onViewDidLoad")
	}
	
	func onViewWillAppear() {
		print("onViewWillAppear")
	}
	
	func onViewDidAppear() {
		print("onViewDidAppear")
	}
	
	func onViewWillDisappear() {
		print("onViewWillDisappear")
	}
	
	func onViewDidDisappear() {
		print("onViewDidDisappear")
	}

}
