//
//  BaseViewProtocol.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import UIKit

protocol BaseViewProtocol: AnyObject {
	
	func showLoadingPopup()
	func hideLoadingPopup()
	func showSimpleError(_ errorText: String)
}
