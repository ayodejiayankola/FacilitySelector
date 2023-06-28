//
//  Facility.swift
//  FacilitySelector
//
//  Created by Ayodeji Ayankola on 28/06/2023.
//

struct Facility: Codable {
	let facilityID, name: String
	let options: [Option]
	
	enum CodingKeys: String, CodingKey {
		case facilityID = "facility_id"
		case name, options
	}
}
