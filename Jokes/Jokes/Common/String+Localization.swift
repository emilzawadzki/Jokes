//
//  String+Localization.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import Foundation

extension String {
	func localized() -> String {
		return NSLocalizedString(self, comment: "")
	}
}
