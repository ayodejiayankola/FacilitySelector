//
//  FacilityViewControllerTests.swift
//  FacilitySelectorTests
//
//  Created by Ayodeji Ayankola on 29/06/2023.
//

import XCTest
@testable import FacilitySelector

class FacilityViewControllerTests: XCTestCase {
		var viewModel: MockFacilityViewModel!
		var viewController: FacilityViewController!

		override func setUp() {
				super.setUp()
				// Create an instance of the mock facility view model
				viewModel = MockFacilityViewModel()
				// Create an instance of the FacilityViewController with the mock view model
				viewController = FacilityViewController(viewModel: viewModel)
				// Load the view hierarchy of the view controller
				viewController.loadViewIfNeeded()
		}

		override func tearDown() {
				viewModel = nil
				viewController = nil
				super.tearDown()
		}

		func testFetchFacilities() {
				// Given
				let tableView = viewController.tableView

				// When
				viewController.fetchFacilities()

				// Then
				XCTAssertNotNil(viewController.facilityData)
				XCTAssertTrue(viewModel.fetchFacilitiesCalled)
				XCTAssertEqual(tableView?.numberOfSections, viewController.facilityData?.facilities.count)
				XCTAssertTrue(tableView?.numberOfRows(inSection: 0) == viewModel.facilityData?.facilities[0].options.count)
		}

		func testToggleOptionSelection() {
				// Given
				let option = Option(name: "Apartment", icon: "apartment", id: "1")
				let cell = FacilityTableViewCell()

				// When
				viewController.handleOptionSelection(option, cell: cell)

				// Then
				XCTAssertTrue(viewModel.toggleOptionSelectionCalled)
				XCTAssertTrue(cell.isCellSelected)
		}

		func testIsOptionSelected() {
				// Given
				let option = Option(name: "Apartment", icon: "apartment", id: "1")
				viewModel.selectedOptions = [Exclusion(facilityID: "1", optionsID: "1")]

				// When
				let isSelected = viewController.viewModel.isOptionSelected(option)

				// Then
				XCTAssertTrue(isSelected)
		}
}
