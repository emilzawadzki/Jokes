//
//  JokesInteractor.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import Foundation

class JokesInteractor: BaseInteractor {
	
	func getJokes(successBlock: @escaping ([JokeModel]) -> Void, errorBlock: @escaping (NSError) -> Void) {
		dataFacade.getJokes(successBlock: { jokes in
			//TODO: add filtering
			successBlock(jokes)
		}, errorBlock: { error in
			errorBlock(error)
		})
		
		
	}
	
}
