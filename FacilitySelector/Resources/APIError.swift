//
//  APIError.swift
//  FacilitySelector
//
//  Created by Ayodeji Ayankola on 28/06/2023.
//

enum APIError: Error {
	case invalidURL
	case invalidResponse
	case decodingError
	case requestFailed(Error)
	case serverError(String)
}
