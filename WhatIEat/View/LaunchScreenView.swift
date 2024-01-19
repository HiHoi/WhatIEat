//
//  LaunchScreenView.swift
//  myFinalSubject
//
//  Created by Hosung Lim on 1/11/24.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
		ZStack {
			Color(Color.accentColor)
				.ignoresSafeArea()
			Image("SplashImage")
				.resizable()
				.scaledToFit()
				.zIndex(0)
		} // MARK: - ZStack
    }
}

#Preview {
    LaunchScreenView()
}
