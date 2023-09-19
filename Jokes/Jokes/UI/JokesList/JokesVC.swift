//
//  JokesVC.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import UIKit

fileprivate let cellIdentifier = "jokeCellIdentifier"

class JokesVC: BaseVC<JokesPresenter>, JokesViewProtocol, UITableViewDelegate, UITableViewDataSource {
	

	@IBOutlet var titleLabel: UILabel!
	@IBOutlet weak var jokesTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		jokesTableView.register(UINib(nibName: "JokeCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
		
		
		titleLabel.text = "listTitle".localized()
	}
	
	func reloadJokesTable() {
		jokesTableView.reloadData()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter?.jokesCount ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
		if let jokeCell = cell as? JokeCell {
			presenter?.setupJokeCell(cell: jokeCell, index: indexPath.row)
		}
		return cell ?? UITableViewCell()
	}

	@IBAction func addJokeTapped(_ sender: Any) {
		presenter?.addJokeTapped()
	}
	
}

