//
//  RecommendView.swift
//  WhatIEat
//
//  Created by Hosung Lim on 1/17/24.
//

import SwiftUI

struct RecommendView: View {
	@ObservedObject var viewModel: RestaurantViewModel
	
	var body: some View {
		VStack {
			Text("오늘 메뉴는?")
			if let recommend = viewModel.recommendFood {
				AsyncImage(url: URL(string: recommend)) { phase in
					switch phase {
					case .empty:
						Text("로딩 중...")
					case .success(let image):
						image
							.resizable()
							.scaledToFit()
					case .failure:
						Text("이미지 로딩 실패")
					@unknown default:
						fatalError()
					}
				}
			}
		} // MARK: - VStack
		.padding()
	}
}

#Preview {
	RecommendView(viewModel: RestaurantViewModel())
}
