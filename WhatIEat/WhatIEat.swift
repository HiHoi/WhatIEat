//
//  myFinalSubjectApp.swift
//  myFinalSubject
//
//  Created by Hosung Lim on 1/11/24.
//

import SwiftUI

@main
struct WhatIEat: App {
	@State var _isLoading = true
	@StateObject var viewModel = RestaurantViewModel()
	
    var body: some Scene {
        WindowGroup {
			ZStack {
				VStack {
					MainPageView(viewModel: viewModel)
				} // MARK: - VSTACK
				if _isLoading {
					LaunchScreenView()
						.transition(.opacity)
						.zIndex(1)
				}
			} // MARK: - ZSTACK
			.onAppear() {
				DispatchQueue.main.asyncAfter(
					deadline: .now() + 3,
					execute: {
						withAnimation {
							_isLoading.toggle()
						}
					}
				)
			} // MARK: - onAppear
        }
    }
}
