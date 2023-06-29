//
//   FacilityViewController.swift
//  FacilitySelector
//
//  Created by Ayodeji Ayankola on 28/06/2023.
//

import UIKit

class FacilityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	@IBOutlet weak var tableView: UITableView!
	
	private var viewModel: FacilityViewModelProtocol
	
	var facilityData: FacilityData?
	
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
		viewModel.fetchFacilities { [weak self] in
			DispatchQueue.main.async {
				self?.facilityData = self?.viewModel.facilityData
				self?.tableView.reloadData()
			}
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return facilityData?.facilities.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return facilityData?.facilities[section].name
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let facilityData = facilityData else {
			return 0
		}
		
		let facility = facilityData.facilities[section]
		return facility.options.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FacilityTableViewCell
		
		guard let facilityData = facilityData else {
			return cell
		}
		
		let facility = facilityData.facilities[indexPath.section]
		
		if indexPath.row < facility.options.count {
			let option = facility.options[indexPath.row]
			cell.configure(with: option)
			cell.isCellSelected = viewModel.isOptionSelected(option)
			cell.selectButtonTapped = { [weak self] in
				self?.handleOptionSelection(option, cell: cell)
			}
		}
		
		return cell
	}
	
	
	private func handleOptionSelection(_ option: Option, cell: FacilityTableViewCell) {
		let isCellSelected = cell.isCellSelected
		
		if isCellSelected {
			viewModel.toggleOptionSelection(option)
			cell.isCellSelected = false
		} else {
			let conflictingOptions = viewModel.selectedOptions.filter { exclusion in
				return (exclusion.facilityID == option.id) &&
				(exclusion.optionsID != option.id)
			}
			
			if conflictingOptions.isEmpty {
				if option.id == "1" {
					deselectOptionWithID("2")
				} else if option.id == "3" {
					if option.id == "12" {
						deselectOptionWithID("7")
					} else if option.id == "7" {
						deselectOptionWithID("12") 
					}
				}
				
				viewModel.toggleOptionSelection(option)
				cell.isCellSelected = true
			} else {
				showAlert(for: conflictingOptions.first!)
			}
		}
	}
	
	private func deselectOptionWithID(_ optionID: String) {
		if let option = viewModel.selectedOptions.first(where: { $0.optionsID == optionID }) {
			if let facilityViewModel = viewModel as? FacilityViewModel,
				 let facilityData = facilityViewModel.facilityData,
				 let facility = facilityData.facilities.first(where: { $0.options.contains { $0.id == option.optionsID } }),
				 let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? FacilityTableViewCell {
				facilityViewModel.toggleOptionSelection(option)
				cell.isCellSelected = false
			}
		}
	}
	
	
	
	
	private func showAlert(for exclusion: Exclusion) {
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

extension FacilityViewController {
	func checkExclusion(for option: Option, in facilityViewController: FacilityViewController) -> Exclusion? {
		guard let facilityData = facilityData else {
			return nil
		}
		
		let selectedExclusion = facilityData.exclusions.first { exclusions in
			let conflictingOptions = exclusions.filter { exclusion in
				exclusion.facilityID == option.id
			}
			
			return conflictingOptions.allSatisfy { exclusion in
				guard let conflictingOption = facilityData.facilities
					.flatMap({ $0.options })
					.first(where: { $0.id == exclusion.optionsID }) else {
					return false
				}
				
				return facilityViewController.viewModel.isOptionSelected(conflictingOption)
			}
		}
		
		return selectedExclusion?.first
	}
}
