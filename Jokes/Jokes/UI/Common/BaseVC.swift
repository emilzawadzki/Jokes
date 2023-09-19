//
//  BaseVC.swift
//  Jokes
//
//  Created by Emil Zawadzki on 19/09/2023.
//

import Foundation
import UIKit

class BaseVC<T: BasePresenter>: UIViewController, BaseViewProtocol {
	
	var presenter: T?
	internal var loadingSpinner: UIActivityIndicatorView?
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		presenter?.onViewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.onViewWillAppear()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		presenter?.onViewDidAppear()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		presenter?.onViewWillDisappear()
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		presenter?.onViewDidDisappear()
	}
	
	func showLoadingPopup() {
		DispatchQueue.main.async {
			guard self.loadingSpinner == nil else {
				// spinner is already displayed
				return
			}
			
			let loadingSpinner = UIActivityIndicatorView(style: .large)
			loadingSpinner.backgroundColor = UIColor.black.withAlphaComponent(0.5)
			self.view.addSubview(loadingSpinner)
			loadingSpinner.startAnimating()
			self.loadingSpinner = loadingSpinner
		}
	}
	
	func hideLoadingPopup() {
		DispatchQueue.main.async {
			self.loadingSpinner?.stopAnimating()
			self.loadingSpinner?.removeFromSuperview()
			self.loadingSpinner = nil
		}
	}
	
	func showSimpleError(_ errorText: String) {
		let alert = UIAlertController(title: nil, message: errorText, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}
