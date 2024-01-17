//
//  IntroFoodsView.swift
//  WhatIEat
//
//  Created by Hosung Lim on 1/17/24.
//

import SwiftUI

struct IntroFoodsView: View {
	@ObservedObject var viewModel: RestaurantViewModel
	@State var currentImageIndex = 0
	
    var body: some View {
		VStack {
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
			}
		}
		.padding()
		.onAppear {
			currentImageIndex = 0
			viewModel.loadRandomPageData()
			
			// MARK: REFACTORY Async / Await
//				Task {
//					currentImageIndex = 0
//					await viewModel.loadRandomImages()
//				}
		}
    }
}

#Preview {
    IntroFoodsView(viewModel: RestaurantViewModel())
}
