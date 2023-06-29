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
		viewModel = FacilityViewModel()
	}
	
	override func tearDown() {
		viewModel = nil
		super.tearDown()
	}
	
	func testFetchFacilities() {
		// Given
		let expectation = XCTestExpectation(description: "Fetch facilities completion called")
		
		// When
		viewModel.fetchFacilities { result in
			// Then
			switch result {
			case .success:
				XCTAssertTrue(self.viewModel.facilities.count > 0)
				XCTAssertNil(self.viewModel.conflictingOptions)
				XCTAssertTrue(self.viewModel.filteredFacilities.count > 0)
			case .failure:
				XCTFail("Fetch facilities failed")
			}
			
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
	
	func testSelectOption() {
		// Given
		let option = Option(name: "Apartment", icon: "apartment", id: "1")
		
		// When
		viewModel.selectOption(option)
		
		// Then
		XCTAssertTrue(viewModel.selectedOptions.contains { $0.optionsID == "1" })
	}
	
	func testDeselectOption() {
		// Given
		let option = Option(name: "Apartment", icon: "apartment", id: "1")
		viewModel.selectOption(option)
		
		// When
		viewModel.deselectOption(option)
		
		// Then
		XCTAssertFalse(viewModel.selectedOptions.contains { $0.optionsID == "1" })
	}
}
