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
	var body: some View {
		HStack {
			TimeView(viewModel: RestaurantViewModel())
		}
	}
}

struct TimeView: View {
	@State var currentTime = Date()
	@State var currentSituation = ""
	@State var currentImageIndex = 0
	var viewModel: RestaurantViewModel
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	
	var body: some View {
		VStack {
			HStack {
				Text("지금 현재 시각은")
					.font(.title2)
			}
			Text(dateFormatted)
				.font(.largeTitle)
			
			// 시간, 분, 초를 표시
			Text(timeFormatted)
				.font(.title)
			
			Spacer()
				.frame(height: 40)
			
			Text("지금은 " + setSituation + " 먹을 시간!!")
				.font(.title2)
			
			Spacer()
				.frame(height: 70)
			
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
			.onAppear {
				currentImageIndex = 0
				viewModel.loadRandomPageData()
				
				// MARK: REFACTORY Async / Await
//				Task {
//					currentImageIndex = 0
//					await viewModel.loadRandomImages()
//				}
			}
			
			Spacer()
			
			Button(action: {
				print("버튼 클릭")
			}) {
				Text("메뉴 추천 받기")
			}
			.buttonStyle(.borderedProminent)
			.controlSize(.large)
			
			Spacer()
				.frame(height: 50)
		}
		.onReceive(timer) { _ in
			currentTime = Date()
		}
		.padding()
		
	}
	
	var dateFormatted: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "MMMM dd"
		return formatter.string(from: currentTime)
	}
	
	// 시간 형식 지정 (시, 분, 초)
	var timeFormatted: String {
		let formatter = DateFormatter()
		formatter.timeStyle = .medium
		return formatter.string(from: currentTime)
	}
	
	var setSituation: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH"
		let timeFormat = formatter.string(from: currentTime)
		
		switch timeFormat {
		case "21"..."24" :
			return ESituation.야식.rawValue
		case "00"..."06" :
			return ESituation.야식.rawValue
		case "07"..."11" :
			return ESituation.아침.rawValue
		case "11"..."14":
			return ESituation.점심.rawValue
		case "17"..."21":
			return ESituation.저녁.rawValue
		default:
			return ESituation.간식.rawValue
		}
	}
}

struct FoodImage : View {
	
	var body: some View {
		ZStack {
			
		}
	}
}

#Preview {
	MainPageView()
}
