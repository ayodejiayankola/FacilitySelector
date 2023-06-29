//
//  FacilityViewModel.swift
//  FacilitySelector
//
//  Created by Ayodeji Ayankola on 28/06/2023.
//


import Foundation

protocol FacilityViewModelProtocol {
		var facilities: [Facility] { get }
		var selectedOptions: [Exclusion] { get set }
		var conflictingOptions: [Exclusion]? { get }
		var filteredFacilities: [Facility] { get }
		
		func fetchFacilities(completion: @escaping (Result<Void, Error>) -> Void)
		func selectOption(_ option: Option)
		func deselectOption(_ option: Option)
}

class FacilityViewModel: FacilityViewModelProtocol {
		private let facilityService: FacilitySelectorApi
		private var facilityData: FacilityData?
		
		var facilities: [Facility] {
				return facilityData?.facilities ?? []
		}
		
		var selectedOptions: [Exclusion] = []
		
		var conflictingOptions: [Exclusion]? {
				let selectedOptionIDs = selectedOptions.map { $0.optionsID }
				
				let conflictingOptions = facilityData?.exclusions
						.flatMap { $0 }
						.filter { exclusion in
								selectedOptionIDs.contains(exclusion.optionsID)
						}
				
				return conflictingOptions
		}
		
		var filteredFacilities: [Facility] {
				guard let facilityData = facilityData else { return [] }
				
				let selectedOptionIDs = selectedOptions.map { $0.optionsID }
				
				let filteredOptions = facilityData.exclusions
						.flatMap { $0 }
						.filter { !selectedOptionIDs.contains($0.optionsID) }
				
				return facilityData.facilities.map { facility in
						let filteredOptionsForFacility = facility.options.filter { option in
								!filteredOptions.contains { $0.facilityID == facility.facilityID && $0.optionsID == option.id }
						}
						
						return Facility(facilityID: facility.facilityID, name: facility.name, options: filteredOptionsForFacility)
				}
		}
		
		init(facilityService: FacilitySelectorApi = FacilitySelectorApi()) {
				self.facilityService = facilityService
		}
		
		func fetchFacilities(completion: @escaping (Result<Void, Error>) -> Void) {
				facilityService.fetchFacilities { [weak self] result in
						switch result {
						case .success(let facilityData):
								self?.facilityData = facilityData
								completion(.success(()))
						case .failure(let error):
								completion(.failure(error))
						}
				}
		}
		
		func selectOption(_ option: Option) {
				let exclusion = Exclusion(facilityID: "", optionsID: option.id)
				
				guard !selectedOptions.contains(exclusion) else {
						return
				}
				
				selectedOptions.append(exclusion)
		}
		
		func deselectOption(_ option: Option) {
				let exclusion = Exclusion(facilityID: "", optionsID: option.id)
				
				selectedOptions.removeAll { $0 == exclusion }
		}
}

