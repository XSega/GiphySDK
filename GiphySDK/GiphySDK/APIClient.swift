//
//  APIClient.swift
//  GiphySDK
//
//  Created by Sergey Ilyushin on 08/10/2019.
//  Copyright © 2019 Sergey Ilyushin. All rights reserved.
//

import Foundation

public protocol APIClientProtocol {
	func get(path: String, parameters: [String: String], completion: @escaping (Result<Data, Error>) -> Void)
}

public struct APIClientConfig {
	let apiKey: String
	
	public init(apiKey: String) {
		self.apiKey = apiKey
	}
}

public class APIClient: APIClientProtocol {
	let baseURL: String
	let session: APISession
	let config: APIClientConfig
	
	public init(baseURL: String = "http://api.giphy.com/v1/", config: APIClientConfig, session: APISession = URLSession.shared) {
		self.baseURL = baseURL
		self.session = session
		self.config = config
	}
	
	public func get(path: String, parameters: [String: String] = [:], completion: @escaping (Result<Data, Error>) -> Void) {
		var result: Result<Data, Error>?
		defer {
			if let result = result {
				completion(result)
			}
		}
		
		var urlComponents = URLComponents()
		var items = parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
		items += [URLQueryItem(name: "api_key", value: config.apiKey)]
		urlComponents.queryItems = items
		
		guard let baseURL = URL(string: baseURL) else {
			return result = .failure(APIClientError.invalidBaseURL)
		}
		guard let url = urlComponents.url(relativeTo: baseURL.appendingPathComponent(path)) else {
			return result = .failure(APIClientError.invalidParams)
		}
		
		print(url.absoluteString)
		let task = session.get(url: url) { (responseResult) in
			return result = responseResult
		}
		task.resume()
	}
}
