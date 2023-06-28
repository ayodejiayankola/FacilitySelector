//
//   APIProtocol.swift
//  FacilitySelector
//
//  Created by Ayodeji Ayankola on 28/06/2023.
//

import Foundation

protocol APIProtocol {
	associatedtype ResponseType: Decodable
	
	func request(endpoint: String, method: HTTPMethod, completion: @escaping (Result<ResponseType, APIError>) -> Void)
}
