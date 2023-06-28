//
//  FacilitySelectorApi.swift
//  FacilitySelector
//
//  Created by Ayodeji Ayankola on 28/06/2023.
//

import Foundation

class FacilitySelectorApi {
	private let api: API<FacilityData>
	
	init(api: API<FacilityData> = API<FacilityData>()) {
		self.api = api
	}
	
	func fetchFacilities(completion: @escaping (Result<FacilityData, APIError>) -> Void) {
		api.request(endpoint: "iranjith4/ad-assignment/db", method: .get, completion: completion)
	}
}

