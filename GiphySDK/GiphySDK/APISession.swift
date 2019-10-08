//
//  APISession.swift
//  GiphySDK
//
//  Created by Sergey Ilyushin on 08/10/2019.
//  Copyright © 2019 Sergey Ilyushin. All rights reserved.
//

import Foundation

public protocol APISession {
	func get(url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> APISessionDataTask
}

public protocol APISessionDataTask {
	func resume()
	func cancel()
}

extension URLSession: APISession {
	public func get(url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> APISessionDataTask {
		var result: Result<Data, Error>?
		defer {
			if let result = result {
				completion(result)
			}
		}
		
		let task = dataTask(with: url) { (data, response, error) in
			switch (data, error) {
				case let (.some(data), .none):
					result = .success(data)
				case let (.none, .some(error)):
					result = .failure(APIClientError.networkError(underlyingError: error))
				case (.none, .none),
					 (.some, .some):
					result = .failure(APIClientError.invalidResponse)
			}
		}
		return task
	}
}

extension URLSessionDataTask: APISessionDataTask {
	
}
