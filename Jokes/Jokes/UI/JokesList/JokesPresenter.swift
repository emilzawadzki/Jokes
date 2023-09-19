//
//  JokesPresenter.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import Foundation

class JokesPresenter: BasePresenter {

	private weak var view : JokesViewProtocol?
	private let router : JokesRouter
	private let interactor : JokesInteractor
	
	init(view: JokesViewProtocol, router: JokesRouter) {
		self.view = view
		self.router = router
		self.interactor = JokesInteractor()
		super.init()
	}
	
	override func onViewDidAppear() {
		interactor.getJokes(successBlock: {jokes in
			var i = 0
			i += 9
		}, errorBlock: {error in
			
		})
	}
	
}
