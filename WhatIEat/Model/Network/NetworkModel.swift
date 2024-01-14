//
//  NetworkModel.swift
//  WhatIEat
//
//  Created by Hosung Lim on 1/12/24.
//

import Foundation
import Alamofire

struct NetworkModel {
	static let shared = NetworkModel()
	private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
	private let apiUrl = "https://api.odcloud.kr/api/15097008/v1"
	private let apiUddi = Bundle.main.object(forInfoDictionaryKey: "API_UDDI") as? String
	private var pageNum = 1
	private var perPageNum = 10
	
	init() {}
	
	func getAllData() -> RestaurantModel? {
		var returnValue: RestaurantModel?
		AF.request("\(apiUrl)/uddi:\(apiUddi!)?page=\(pageNum)&perPage=\(perPageNum)&serviceKey=\(apiKey!.utf8)")
			.responseDecodable(of: RestaurantModel.self) { response in
				switch response.result {
				case .success(let restaurantData):
					returnValue = restaurantData
				case .failure(let error):
					print("Error: \(error)")
				}
			}
		return returnValue
	}
	
	func getRandomPageData(completion: @escaping (RestaurantModel?) -> Void) {
		let randomPageNumber = Int.random(in: 1..<100)
		AF.request("\(apiUrl)/uddi:\(apiUddi!)?page=\(randomPageNumber)&perPage=\(perPageNum)&serviceKey=\(apiKey!.utf8)")
			.responseDecodable(of: RestaurantModel.self) { response in
				switch response.result {
				case .success(let restaurantData):
					completion(restaurantData)
				case .failure(let error):
					print("Error: \(error)")
					completion(nil)
				}
			}
	}
	
	func getRandomImageData() async -> RestaurantModel? {
		let randomPageNumber = Int.random(in: 1..<100)
		var resultValue: RestaurantModel?
		AF.request("\(apiUrl)/uddi:\(apiUddi!)?page=\(randomPageNumber)&perPage=\(perPageNum)&serviceKey=\(apiKey!.utf8)")
			.responseDecodable(of: RestaurantModel.self) { response in
				switch response.result {
				case .success(let restaurantData):
					resultValue = restaurantData
				case .failure(let error):
					print("Error: \(error)")
				}
			}
		return resultValue
	}
}
