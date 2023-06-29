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
				viewModel = MockFacilityViewModel()
				viewController = FacilityViewController(viewModel: viewModel)
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
				XCTAssertNotNil(viewController.viewModel.facilities)
				XCTAssertNil(viewController.viewModel.conflictingOptions)
				XCTAssertTrue(tableView?.numberOfSections == viewController.viewModel.facilities.count)
				XCTAssertTrue(tableView?.numberOfRows(inSection: 0) == viewController.viewModel.facilities[0].options.count)
		}

		func testHandleOptionSelection() {
				// Given
				let option = Option(name: "Apartment", icon: "apartment", id: "1")
				let cell = FacilityTableViewCell()

				// When
				viewController.handleOptionSelection(option, cell: cell)

				// Then
				XCTAssertTrue(viewModel.selectOptionCalled)
				XCTAssertTrue(cell.isCellSelected)
		}

		func testIsOptionSelected() {
				// Given
				let option = Option(name: "Apartment", icon: "apartment", id: "1")
				viewModel.selectedOptions = [Exclusion(facilityID: "1", optionsID: "1")]

				// When
				let isSelected = viewController.viewModel.selectedOptions.contains { $0.optionsID == option.id }

				// Then
				XCTAssertTrue(isSelected)
		}
}
