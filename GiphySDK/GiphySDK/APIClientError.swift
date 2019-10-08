//
//  APIClientError.swift
//  GiphySDK
//
//  Created by Sergey Ilyushin on 08/10/2019.
//  Copyright © 2019 Sergey Ilyushin. All rights reserved.
//

import Foundation

enum APIClientError: Error {
	case invalidRequest
	case invalidResponse
	case invalidResponseDataType
	case networkError(underlyingError: Error)
	case invalidURL
	case invalidParams
	case invalidBaseURL
	
	var localizedDescription: String {
		switch self {
			case .invalidRequest:
				return "Invalid Request"
			case .invalidResponse:
				return "Invalid Response"
			case .invalidResponseDataType:
				return "Invalid Response Data Type"
			case let .networkError(error):
				return "Network error:\n\(error.localizedDescription)"
			case .invalidURL:
				return "Invalid URL"
			case .invalidParams:
				return "Invalid Parameters"
			case .invalidBaseURL:
				return "Invalid Base URL"
		}
	}
}
