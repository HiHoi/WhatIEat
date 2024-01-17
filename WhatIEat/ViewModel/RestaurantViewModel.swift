//
//  RestaurantViewModel.swift
//  WhatIEat
//
//  Created by Hosung Lim on 1/14/24.
//

import Foundation

class RestaurantViewModel: ObservableObject {
	@Published var restaurantModel: RestaurantModel?
	@Published var randomThumbnailPhoto: [String]?
	@Published var recommendFood: String?
	private var network: NetworkModel = NetworkModel()
	
	// MARK: 랜덤한 음식 10개 뽑기
	func loadRandomPageData() {
		network.getRandomPageData() { randomRestaurant in
			if let randomRestaurant = randomRestaurant {
				let randomData = randomRestaurant.data
				let imageList = randomData.map { Restaurant in
					return Restaurant.음식이미지URL
				}
				DispatchQueue.main.async {
					self.randomThumbnailPhoto = imageList
				}
			} else {
				print("언래핑 실패")
				DispatchQueue.main.async {
					self.randomThumbnailPhoto = nil
				}
			}
		}
	}
	
	// MARK: 추천 음식 뽑기
	func loadRecommend() {
		let randomPageNumber = Int.random(in: 1..<10)
		
		network.getRandomPageData() { randomRestaurant in
			if let randomRestaurant = randomRestaurant {
				let randomData = randomRestaurant.data
				let imageList = randomData.map { Restaurant in
					return Restaurant.음식이미지URL
				}
				DispatchQueue.main.async {
					self.recommendFood = imageList[randomPageNumber]
				}
			} else {
				print("언래핑 실패")
				DispatchQueue.main.async {
					self.randomThumbnailPhoto = nil
				}
			}
		}
	}
	
	// MARK: - TODO async 문법으로 리팩토링
	func loadRandomImages() async {
		if let randomImage = await network.getRandomImageData() {
			let randomData = randomImage.data
			let imageList = randomData.map { restaurant in
				return restaurant.음식이미지URL
			}
			randomThumbnailPhoto = imageList
		} else {
			print("언래핑 실패")
			randomThumbnailPhoto = nil
		}
	}
}
