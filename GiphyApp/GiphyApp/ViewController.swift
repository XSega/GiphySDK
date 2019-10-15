//
//  ViewController.swift
//  GiphyApp
//
//  Created by Sergey Ilyushin on 08/10/2019.
//  Copyright © 2019 Sergey Ilyushin. All rights reserved.
//

import UIKit
import GiphySDK

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		let config = APIClientConfig(apiKey: "pkzR9y9XVaDRZNn1WcdzjNvLUXh15n0T")
		let apiClient = APIClient(config: config)
		apiClient.get(path: "gifs/random", parameters: [:]) { (result) in			
		}
	}


}

