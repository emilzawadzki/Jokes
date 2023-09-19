//
//  JokeCell.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import Foundation
import UIKit

class JokeCell: UITableViewCell {
	
	var jokeID: Int?
	weak var presenterDelegate: JokesPresenterDelegate?
	
	@IBOutlet var categoryLabel: UILabel!
	@IBOutlet var jokeImage: UIImageView!
	@IBOutlet var setupLabel: UILabel!
	@IBOutlet var deliveryLabel: UILabel!
	
	
	override func awakeFromNib() {
		backgroundColor = .clear
	}
	
	func hideDelivery() {
		deliveryLabel.alpha = 0
	}
	
	func revealDelivery() {
		UIView.animate(withDuration: 1.0, animations: {
			self.deliveryLabel.alpha = 1
		})
	}
	
	@IBAction func cellTapped(_ sender: UIButton) {
		guard let presenterDelegate = presenterDelegate else {
			print("nil presenter delegate")
			return
		}
		presenterDelegate.jokeTapped(cell: self)
	}
}
