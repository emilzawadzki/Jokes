//
//  ViewController.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import UIKit

class ViewController: UIViewController {
	
	let facade = JokesDataFacade()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		facade.getJokes(successBlock: {jokes in
			var i = 0
			i += 9
		}, errorBlock: { error in
			
		})
	}


}

