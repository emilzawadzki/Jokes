//
//  AddJokePresenter.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import Foundation

class AddJokePresenter: BasePresenter {

	private weak var view : AddJokeProtocol?
	private let router : JokesRouter
	private let interactor : AddJokeInteractor
	
	init(view: AddJokeProtocol, router: JokesRouter) {
		self.view = view
		self.router = router
		self.interactor = AddJokeInteractor()
		super.init()
	}
	
	override func onViewDidAppear() {
		
	}
	
	
	
}
