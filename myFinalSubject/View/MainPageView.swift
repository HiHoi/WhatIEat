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
			TimeView()
		}
	}
}

struct TimeView: View {
	@State var currentTime = Date()
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	@State var currentSituation = ""
	
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
				.frame(height: 100)
			
			Image("example")
				.resizable()
				.scaledToFit()
			
			Spacer()
				
			Button(action: {}) {
				Text("메뉴 추천 받기")
			}
			
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
		print(timeFormat)
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

#Preview {
	MainPageView()
}
