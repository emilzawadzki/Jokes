//
//  JokesInteractor.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import Foundation
import UIKit

fileprivate let defaultLanguageCode = "en"
let maxRating = 5

class JokesInteractor: BaseInteractor {
	
	private var databaseHelper: DatabaseHelper
	
	override init() {
		databaseHelper = DatabaseHelper()
	}
	
	func getJokes(languageCode: String? = Locale.current.language.languageCode?.identifier, retryCount: Int = 0, successBlock: @escaping ([JokeModel]) -> Void, errorBlock: @escaping (NSError) -> Void) {
		dataFacade.getJokes(languageCode: languageCode,successBlock: { jokes in
			var filteredJokes = jokes.filter {
				!$0.nsfwFlag
			}
			filteredJokes.sort(by: { $0.id < $1.id })
			successBlock(filteredJokes)
		}, errorBlock: { [weak self] error in
			if languageCode == Locale.current.language.languageCode?.identifier && retryCount == 0 {
				// retry with default language
				print("No jokes for phone language, retry with default language")
				self?.getJokes(languageCode:defaultLanguageCode, retryCount: retryCount+1, successBlock: successBlock, errorBlock: errorBlock)
			} else {
				errorBlock(error)
			}
		})
	}
	
	func getImage(forJokeWithID jokeID: Int, completion: @escaping (UIImage) -> Void) {
		
		let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)
		let cachesDirectory = paths[0]
		guard let cacheDirURL = URL(string: cachesDirectory) else {
			print("Error when accessing cachesDirectory")
			return
		}
		
		func loadAndReturnImage(from path: String?) {
			guard let path = path, let image = UIImage(contentsOfFile: path) else {
				return
			}
			DispatchQueue.main.async {
				completion(image)
			}
		}
		
		let dataPath = cacheDirURL.appendingPathComponent(Constants.cachedImagesFolder).appendingPathComponent("\(jokeID).jpg")
		if FileManager.default.fileExists(atPath: dataPath.path) {
			print("Using cached image for joke \(jokeID)")
			loadAndReturnImage(from: dataPath.path)
		} else {
			print("No cached image for joke \(jokeID). Fetching")
			self.dataFacade.getJokeImagePath(jokeId: jokeID) { path in
				print("Image for joke \(jokeID) fetched")
				if let path = path {
					loadAndReturnImage(from: path)
				}
			} errorBlock: { error in
				print("Unable to fetch image for joke \(jokeID). \(error)")
				loadAndReturnImage(from: nil)
			}
		}
		
	}
	
	func getRating(forJokeWithID jokeID: Int) -> Int {
		// default value
		return databaseHelper.jokeRating(jokeId: jokeID)
	}
	
	func rateJoke(jokeID: Int, rating: Int) {
		databaseHelper.saveRating(jokeId: jokeID, rating: rating)
	}
	
}
