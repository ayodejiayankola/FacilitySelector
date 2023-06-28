//
//  Root.swift
//  FacilitySelector
//
//  Created by Ayodeji Ayankola on 28/06/2023.
//

struct FacilityData: Codable {
	let facilities: [Facility]
	let exclusions: [[Exclusion]]
	
	enum CodingKeys: String, CodingKey {
		case facilities, exclusions
	}
}

