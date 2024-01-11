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
			Image("SplashImage")
				.resizable()
				.scaledToFit()
				.zIndex(0)
		}
		.background(.white)
    }
}

#Preview {
    LaunchScreenView()
}
