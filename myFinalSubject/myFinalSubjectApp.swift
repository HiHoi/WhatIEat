//
//  myFinalSubjectApp.swift
//  myFinalSubject
//
//  Created by Hosung Lim on 1/11/24.
//

import SwiftUI

@main
struct myFinalSubjectApp: App {
	@State var _isLoading = true
    var body: some Scene {
        WindowGroup {
			ZStack {
				VStack {
					MainPageView()
				} // VSTACK
				if _isLoading {
					LaunchScreenView().transition(.opacity).zIndex(1)
				}
			} // ZSTACK
			.onAppear() {
				DispatchQueue.main.asyncAfter(
					deadline: .now() + 3,
					execute: {
						withAnimation {
							_isLoading.toggle()
						}
					}
				)
			}
        }
    }
}
