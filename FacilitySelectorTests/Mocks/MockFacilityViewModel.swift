//
//  MockFacilityViewModel.swift
//  FacilitySelectorTests
//
//  Created by Ayodeji Ayankola on 29/06/2023.
//

import Foundation
@testable import FacilitySelector

class MockFacilityViewModel: FacilityViewModelProtocol {
		var facilities: [Facility] = []
		var selectedOptions: [Exclusion] = []
		var conflictingOptions: [Exclusion]? = []
		var filteredFacilities: [Facility] = []
		
		var fetchFacilitiesCalled = false
		var selectOptionCalled = false
		var deselectOptionCalled = false
		
		init() {
				facilities = createMockFacilities()
		}
		
		private func createMockFacilities() -> [Facility] {
				let facility1 = Facility(facilityID: "1", name: "Property Type", options: [
						Option(name: "Apartment", icon: "apartment", id: "1"),
						Option(name: "Condo", icon: "condo", id: "2"),
						Option(name: "Boat House", icon: "boat", id: "3"),
						Option(name: "Land", icon: "land", id: "4")
				])
				
				let facility2 = Facility(facilityID: "2", name: "Number of Rooms", options: [
						Option(name: "1 to 3 Rooms", icon: "rooms", id: "6"),
						Option(name: "No Rooms", icon: "no-room", id: "7")
				])
				
				let facility3 = Facility(facilityID: "3", name: "Other facilities", options: [
						Option(name: "Swimming Pool", icon: "swimming", id: "10"),
						Option(name: "Garden Area", icon: "garden", id: "11"),
						Option(name: "Garage", icon: "garage", id: "12")
				])
				
				return [facility1, facility2, facility3]
		}
		
		func fetchFacilities(completion: @escaping (Result<Void, Error>) -> Void) {
				fetchFacilitiesCalled = true
				facilities = createMockFacilities()
				completion(.success(()))
		}
		
		func selectOption(_ option: Option) {
				selectOptionCalled = true
		}
		
		func deselectOption(_ option: Option) {
				deselectOptionCalled = true
		}
}
