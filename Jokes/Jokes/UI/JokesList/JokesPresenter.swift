//
//  JokesPresenter.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import Foundation

protocol JokesPresenterDelegate : BasePresenter {
	func jokeTapped(cell: JokeCell)
	func ratingChanged(cell: JokeCell, rating: Int)
}

class JokesPresenter: BasePresenter, JokesPresenterDelegate {

	private weak var view : JokesViewProtocol?
	private let router : JokesRouter
	private let interactor : JokesInteractor
	private var jokes: [JokeModel]?
	
	var jokesCount: Int {
		return jokes?.count ?? 0
	}
	
	init(view: JokesViewProtocol, router: JokesRouter) {
		self.view = view
		self.router = router
		self.interactor = JokesInteractor()
		super.init()
	}
	
	override func onViewDidAppear() {
		view?.showLoadingPopup()
		interactor.getJokes(successBlock: {[weak self] jokes in
			DispatchQueue.main.async {
				self?.view?.hideLoadingPopup()
				self?.jokes = jokes
				self?.view?.reloadJokesTable()
			}
		}, errorBlock: {[weak self] error in
			DispatchQueue.main.async {
				self?.view?.hideLoadingPopup()
				//TODO: check error type
				self?.view?.showSimpleError("errorDescription".localized())
			}
		})
	}
	
	func setupJokeCell(cell: JokeCell, index: Int) {
		guard let jokes = jokes, index < jokes.count else {
			return
		}
		let joke = jokes[index]
		cell.hideDelivery()
		cell.jokeID = joke.id
		cell.categoryLabel.text = joke.category
		cell.setupLabel.text = joke.setup
		cell.deliveryLabel.text = joke.delivery
		let rating = interactor.getRating(forJokeWithID: joke.id)
		cell.setRating(rating: rating)
		cell.presenterDelegate = self
		interactor.getImage(forJokeWithID: joke.id, completion: { image in
			if cell.jokeID == joke.id {
				DispatchQueue.main.async {
					cell.jokeImage.image = image
				}
			}
		})
	}
	
	func jokeTapped(cell: JokeCell) {
		cell.revealDelivery()
	}
	
	func ratingChanged(cell: JokeCell, rating: Int) {
		guard let jokeID = cell.jokeID else {
			return
		}
		interactor.rateJoke(jokeID: jokeID, rating: rating)
		cell.setRatingLabelValue(rating: rating)
	}
	
	
	func addJokeTapped() {
//		if let addVC = router.getAddJokesView() {
//			router.navigationController()?.present(addVC, animated: true)
//		}
		view?.showSimpleError("inProgress".localized())
	}
}
