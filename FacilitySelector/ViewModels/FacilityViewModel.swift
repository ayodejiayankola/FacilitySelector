//
//  FacilityViewModel.swift
//  FacilitySelector
//
//  Created by Ayodeji Ayankola on 28/06/2023.
//

protocol FacilityViewModelProtocol {
	var facilityData: FacilityData? { get }
	var error: APIError? { get }
	var selectedOptions: [Exclusion] { get }
	
	func fetchFacilities(completion: @escaping () -> Void)
	func toggleOptionSelection(_ option: Option)
	func isOptionSelected(_ option: Option) -> Bool
}

class FacilityViewModel: FacilityViewModelProtocol {
	private let facilityService: FacilitySelectorApi
	
	var facilityData: FacilityData?
	var error: APIError?
	var selectedOptions: [Exclusion] = []
	
	init(facilityService: FacilitySelectorApi = FacilitySelectorApi()) {
		self.facilityService = facilityService
	}
	
	func toggleOptionSelection(_ option: Option) {
		guard let facilityID = facilityData?.facilities.first(where: { $0.options.contains { $0.id == option.id } })?.facilityID else {
			return
		}
		
		let exclusion = Exclusion(facilityID: facilityID, optionsID: option.id)
		
		if let index = selectedOptions.firstIndex(where: { $0.facilityID == facilityID }) {
			selectedOptions.remove(at: index)
		} else {
			selectedOptions.append(exclusion)
		}
	}
	
	func toggleOptionSelection(_ exclusion: Exclusion) {
			if let index = selectedOptions.firstIndex(where: { $0 == exclusion }) {
					selectedOptions.remove(at: index)
			} else {
					selectedOptions.append(exclusion)
			}
	}

	
	func isOptionSelected(_ option: Option) -> Bool {
		guard let facilityID = facilityData?.facilities.first(where: { $0.options.contains { $0.id == option.id } })?.facilityID else {
			return false
		}
		
		return selectedOptions.contains(where: { $0.facilityID == facilityID })
	}
	
	func fetchFacilities(completion: @escaping () -> Void) {
		facilityService.fetchFacilities { [weak self] result in
			switch result {
			case .success(let data):
				self?.facilityData = data
				self?.error = nil
			case .failure(let error):
				self?.facilityData = nil
				self?.error = error
			}
			
			completion()
		}
	}
}
