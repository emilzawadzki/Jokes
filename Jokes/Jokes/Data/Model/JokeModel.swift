//
//  JokeModel.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import Foundation
import SwiftyJSON


/// Example data
/// "category": "Pun",
/// "type": "twopart",
/// "setup": "I asked my wife if I was the only one she's been with.",
/// "delivery": "She said, \"Yes, the others were at least sevens or eights.\"",
/// "flags": {
/// "nsfw": false,
/// "religious": false,
/// "political": false,
/// "racist": false,
/// "sexist": false,
/// "explicit": false
/// },
/// "id": 58,
/// "safe": true,
/// "lang": "en"


class JokeModel {
	
	var id: Int
	var setup: String
	var delivery: String
	
	var type: String
	var category: String
	var nsfwFlag: Bool
	var lang: String
	
	init?(jsonData: JSON) {
		guard let id = jsonData["id"].int,
			  let setup = jsonData["setup"].string,
			  let delivery = jsonData["delivery"].string else {
			return nil
		}
		self.id = id
		self.setup = setup
		self.delivery = delivery
		
		self.type = jsonData["type"].stringValue
		self.category = jsonData["category"].stringValue
		self.nsfwFlag = jsonData["flags"]["nsfw"].boolValue
		self.lang = jsonData["lang"].stringValue
	}
	
}
