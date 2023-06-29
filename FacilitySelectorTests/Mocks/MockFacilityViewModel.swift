//
//  MockFacilityViewModel.swift
//  FacilitySelectorTests
//
//  Created by Ayodeji Ayankola on 29/06/2023.
//

import Foundation
@testable import FacilitySelector

class MockFacilityViewModel: FacilityViewModelProtocol {
		var facilityData: FacilityData?
		var error: APIError?
		var selectedOptions: [Exclusion] = []

		var fetchFacilitiesCalled = false
		var toggleOptionSelectionCalled = false
		var isOptionSelectedCalled = false

		init() {
				facilityData = createMockFacilityData()
		}

		private func createMockFacilityData() -> FacilityData {
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

				let facilities = [facility1, facility2, facility3]

				let exclusions = [
						[Exclusion(facilityID: "1", optionsID: "4"), Exclusion(facilityID: "2", optionsID: "6")],
						[Exclusion(facilityID: "1", optionsID: "3"), Exclusion(facilityID: "3", optionsID: "12")],
						[Exclusion(facilityID: "2", optionsID: "7"), Exclusion(facilityID: "3", optionsID: "12")]
				]

				return FacilityData(facilities: facilities, exclusions: exclusions)
		}

		func fetchFacilities(completion: @escaping () -> Void) {
				fetchFacilitiesCalled = true
				facilityData = createMockFacilityData()
				completion()
		}

		func toggleOptionSelection(_ option: Option) {
				toggleOptionSelectionCalled = true
		}

		func isOptionSelected(_ option: Option) -> Bool {
				isOptionSelectedCalled = true
				return false
		}
}
