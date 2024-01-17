//
//  MainPageView.swift
//  myFinalSubject
//
//  Created by Hosung Lim on 1/11/24.
//

import SwiftUI

enum ESituation: String {
	case 야식
	case 아침
	case 점심
	case 저녁
	case 간식
	
}

struct MainPageView: View {
	@State var isClick = false
	@ObservedObject var viewModel: RestaurantViewModel
	
	var body: some View {
		VStack {
			TimeView()

			Spacer()
				.frame(height: 50)
			
			VStack {
				if isClick {
					RecommendView(viewModel: viewModel)
				} else {
					IntroFoodsView(viewModel: viewModel)
				}
			} // MARK: - VStack
			
			Spacer()
			
			HStack {
				Button(action: {
					print("버튼 클릭")
					viewModel.loadRecommend()
					isClick = true
				}) {
					if isClick {
						Text("다시 추천 받기")
					} else {
						Text("메뉴 추천 받기")
					}
				}
				.buttonStyle(.borderedProminent)
				.controlSize(.large)
				
				if isClick {
					Button(action: {
						isClick = false
					}, label: {
						Image(systemName: "arrow.clockwise")
					})
				}
			} // MARK: - HStack
			
			Spacer()
				.frame(height: 50)
			
		} // MARK: - VStack
	}
}


#Preview {
	MainPageView(viewModel: RestaurantViewModel())
}
