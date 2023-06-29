//
//  FacilityViewModelTests.swift
//  FacilitySelectorTests
//
//  Created by Ayodeji Ayankola on 29/06/2023.
//

import XCTest
@testable import FacilitySelector

class FacilityViewModelTests: XCTestCase {
		var viewModel: FacilityViewModelProtocol!

		override func setUp() {
				super.setUp()
				viewModel = MockFacilityViewModel()
		}

		override func tearDown() {
				viewModel = nil
				super.tearDown()
		}

		func testFetchFacilities() {
				// Given
				let expectation = XCTestExpectation(description: "Fetch facilities completion called")

				// When
				viewModel.fetchFacilities {
						// Then
						XCTAssertTrue(self.viewModel.facilityData != nil)
						XCTAssertNil(self.viewModel.error)
						XCTAssertTrue((self.viewModel.facilityData?.facilities.count ?? 0) > 0)
						expectation.fulfill()
				}

				wait(for: [expectation], timeout: 1.0)
		}

		func testToggleOptionSelection() {
				// Given
				let option = Option(name: "Apartment", icon: "apartment", id: "1")

				// When
				viewModel.toggleOptionSelection(option)

				// Then
				XCTAssertTrue(viewModel.selectedOptions.contains { $0.facilityID == "1" && $0.optionsID == "1" })
		}

		func testIsOptionSelected() {
				// Given
				let option = Option(name: "Apartment", icon: "apartment", id: "1")
				viewModel.toggleOptionSelection(option)

				// When
				let isSelected = viewModel.isOptionSelected(option)

				// Then
				XCTAssertTrue(isSelected)
		}
}
