//
//  FacilityViewControllerTests.swift
//  FacilitySelectorTests
//
//  Created by Ayodeji Ayankola on 29/06/2023.
//

import UIKit

class FacilityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	@IBOutlet weak var tableView: UITableView!
	
	internal private(set) var viewModel: FacilityViewModelProtocol
	
	init(viewModel: FacilityViewModelProtocol) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		self.viewModel = FacilityViewModel()
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.dataSource = self
		tableView.delegate = self
		fetchFacilities()
	}
	
	func fetchFacilities() {
		viewModel.fetchFacilities { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case .success:
					self?.tableView.reloadData()
				case .failure(let error):
					self?.showErrorAlert(error)
				}
			}
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return viewModel.facilities.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return viewModel.facilities[section].name
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let facility = viewModel.facilities[section]
		return facility.options.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FacilityTableViewCell
		
		let facility = viewModel.facilities[indexPath.section]
		let option = facility.options[indexPath.row]
		
		cell.configure(with: option)
		cell.isCellSelected = viewModel.selectedOptions.contains { $0.optionsID == option.id }
		
		cell.selectButtonTapped = { [weak self] in
			self?.handleOptionSelection(option, cell: cell)
		}
		
		return cell
	}
	
	internal func handleOptionSelection(_ option: Option, cell: FacilityTableViewCell) {
		let isCellSelected = cell.isCellSelected
		
		if isCellSelected {
			viewModel.deselectOption(option)
			cell.isCellSelected = false
		} else {
			let conflictingOptions = viewModel.conflictingOptions ?? []
			
			if conflictingOptions.isEmpty {
				viewModel.selectOption(option)
				cell.isCellSelected = true
			} else {
				showAlert(for: conflictingOptions)
			}
		}
	}
	
	// Mark:- Alert to show error in displaying data
	
	private func showErrorAlert(_ error: Error) {
		let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
		let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
		alertController.addAction(dismissAction)
		
		present(alertController, animated: true, completion: nil)
	}
	
	// Mark:- Alert to manage confilicting exclusion options
	
	private func showAlert(for conflictingOptions: [Exclusion]) {
		guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
					let window = windowScene.windows.first,
					let rootViewController = window.rootViewController else {
			return
		}
		
		let alertController = UIAlertController(title: "Invalid Selection", message: "Combination cannot be selected. Please deselect the currently selected option.", preferredStyle: .alert)
		let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
		alertController.addAction(dismissAction)
		
		rootViewController.present(alertController, animated: true, completion: nil)
	}
}

