//
//  Exclusion.swift
//  FacilitySelector
//
//  Created by Ayodeji Ayankola on 28/06/2023.
//


struct Exclusion: Codable, Equatable {
	let facilityID, optionsID: String
	
	enum CodingKeys: String, CodingKey {
		case facilityID = "facility_id"
		case optionsID = "options_id"
	}
	
	static func == (lhs: Exclusion, rhs: Exclusion) -> Bool {
		return lhs.facilityID == rhs.facilityID && lhs.optionsID == rhs.optionsID
	}
}

