//
//  IntroFoodView.swift
//  WhatIEat
//
//  Created by Hosung Lim on 1/17/24.
//

import SwiftUI

struct IntroFoodView : View {
	@State var currentImageIndex = 0
	@State var imagesLoaded = false
	@State var errorMessage: String?
	@ObservedObject var viewModel: RestaurantViewModel
	
	var body: some View {
		VStack {
			if imagesLoaded {
				if let imagesUrl = viewModel.randomThumbnailPhoto {
					ForEach(imagesUrl.indices, id: \.self) { index in
						if index == currentImageIndex {
							AsyncImage(url: URL(string: imagesUrl[index])) { phase in
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
							.transition(.opacity)
							.animation(.easeInOut(duration: 1.0), value: currentImageIndex)
							.onAppear {
								DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
									withAnimation(.easeInOut(duration: 1.0)) {
										currentImageIndex = (currentImageIndex + 1) % imagesUrl.count
									}
								}
							}
						}
					}
				} else {
					Text("Error")
				}
			} else if let message = errorMessage {
				Text(message)
			} else {
				Text("이미지 로딩 중...")
			}
		}
		.task {
			do {
				try await viewModel.loadRandom()
				imagesLoaded = true
			} catch {
				errorMessage = error.localizedDescription
			}
		}
	}
}

#Preview {
	IntroFoodView(viewModel: RestaurantViewModel())
}

