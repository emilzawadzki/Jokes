//
//  BaseInteractor.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import UIKit
import SwiftyJSON

class BaseInteractor: NSObject {
	
	var dataFacade = JokesDataFacade()
	
	override init() {
		super.init()
	}
}
