//
//  JokesDataFacade.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class JokesDataFacade {
	
	private var apiUrl = "https://v2.jokeapi.dev"
	
	private let session: Session = {
		let configuration = URLSessionConfiguration.default
		configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
		return Session(configuration: configuration)
	}()
	
	private func getCommonHeaders() -> HTTPHeaders {
		return [
			"Content-Type" : "application/json"
		]
	}
	
	/// https://v2.jokeapi.dev/joke/Any?lang=es&type=twopart
	/// or https://v2.jokeapi.dev/joke/Any?type=twopart
	func getJokes(languageCode: String? = nil, successBlock: @escaping ([JokeModel]) -> Void, errorBlock: @escaping (NSError) -> Void) {
		
		var fullUrl = apiUrl + "/joke/Any?"
		// english as default and empty parameter
		if let languageCode {
			fullUrl += "lang=\(languageCode)&"
		}
		fullUrl += "type=twopart&amount=20"
	
		guard let url = URL(string: fullUrl) else {
			print("Wrong API url: " + apiUrl)
			errorBlock(NSError(domain: "Wrong API url: " + apiUrl, code: 0, userInfo: nil))
			return
		}
		
		let request = session.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: getCommonHeaders())
		
		request.responseJSON() { response in
			switch response.result {
			case .success:
				let statusCode = response.response?.statusCode ?? 0
				if statusCode == 200 {
					
					guard let data = response.data, let jsonData = try? JSON(data: data) else {
						print("Unable to parse JSON for request \(fullUrl). http code: \(statusCode)")
						errorBlock(NSError(domain: "Unable to parse json data", code: statusCode, userInfo: nil) )
						return
					}
					print("Response for \(fullUrl): SUCCESS!")
					if jsonData["error"].boolValue == true {
						print("Wrong response for request \(fullUrl). http code: \(statusCode). response string: \(String(describing: String(data: data, encoding: .utf8)))")
						errorBlock(NSError(domain: "Wrong response for request", code: statusCode, userInfo: nil) )
					} else {
						
						if jsonData["amount"].intValue > 1 {
							var jokesArray = [JokeModel]()
							for jokeJson in jsonData["jokes"].arrayValue {
								if let joke = JokeModel(jsonData: jokeJson) {
									jokesArray.append(joke)
								}
							}
							successBlock(jokesArray)
						} else {
							//TODO: different response for only one joke
							print("Wrong response for request \(fullUrl). http code: \(statusCode). response string: \(String(describing: String(data: data, encoding: .utf8)))")
							errorBlock(NSError(domain: "Wrong response for request", code: statusCode, userInfo: nil) )
						}
						
					}
				} else {
					print("API returned \(statusCode) HTTP code")
					errorBlock(NSError(domain: "API returned \(statusCode) HTTP code", code: statusCode))
				}
			case .failure(let error):
				print("Request: \(fullUrl) failed with error: \(error.localizedDescription)")
				errorBlock(error as NSError)
			}
		}
		
	}
}
