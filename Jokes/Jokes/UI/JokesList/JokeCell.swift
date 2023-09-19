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
	@IBOutlet var ratingLabel: UILabel!
	@IBOutlet var ratingView: UIView!
	@IBOutlet var ratingControl: UISegmentedControl!
	@IBOutlet var rateLabel: UILabel!
	
	override func awakeFromNib() {
		backgroundColor = .clear
		rateLabel.text = "rateLabel".localized()
	}
	
	func hideDelivery() {
		deliveryLabel.alpha = 0
		ratingView.alpha = 0
	}
	
	func revealDelivery() {
		UIView.animate(withDuration: 1.0, animations: {
			self.deliveryLabel.alpha = 1
			self.ratingView.alpha = 1
		})
	}
	
	@IBAction func cellTapped(_ sender: UIButton) {
		guard let presenterDelegate = presenterDelegate else {
			print("nil presenter delegate")
			return
		}
		presenterDelegate.jokeTapped(cell: self)
	}
	
	func setRatingLabelValue(rating: Int) {
		ratingLabel.text = "ratingLabel".localized() + " \(rating)/\(maxRating)"
	}
	
	func setRating(rating: Int) {
		setRatingLabelValue(rating: rating)
		if rating > 0 && rating <= maxRating {
			ratingControl.selectedSegmentIndex = rating - 1
		}
	}
	@IBAction func ratingChanged(_ sender: Any) {
		guard let presenterDelegate = presenterDelegate else {
			print("nil presenter delegate")
			return
		}
		// selectedSegmentIndex has values 0-4, but rating has values 1-5
		presenterDelegate.ratingChanged(cell: self, rating: ratingControl.selectedSegmentIndex + 1)
	}
}
