//
//  MockFacilityService.swift
//  FacilitySelectorTests
//
//  Created by Ayodeji Ayankola on 29/06/2023.
//

import Foundation
@testable import FacilitySelector

class MockFacilityService: FacilitySelectorApi {
				var fetchFacilitiesResult: Result<FacilityData, APIError>!
				
				override func fetchFacilities(completion: @escaping (Result<FacilityData, APIError>) -> Void) {
						completion(fetchFacilitiesResult)
				}
}
