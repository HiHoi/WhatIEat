//
//  FoodModel.swift
//  WhatIEat
//
//  Created by Hosung Lim on 1/12/24.
//

import Foundation

struct Restaurant: Codable {
	let 메뉴ID: Int
	let 식당ID: Int
	let 식당명: String
	let 음식이미지ID: Int
	let 음식이미지URL: String
	let 지역명: String
	
	enum CodingKeys: String, CodingKey {
		case 메뉴ID = "메뉴(ID)"
		case 식당ID = "식당(ID)"
		case 식당명
		case 음식이미지ID = "음식이미지(ID)"
		case 음식이미지URL = "음식이미지(URL)"
		case 지역명
	}
}

struct RestaurantModel: Codable {
	let page: Int
	let matchCount: Int
	let data: [Restaurant]
	let currentCount: Int
	let totalCount: Int
	let perPage: Int
}
