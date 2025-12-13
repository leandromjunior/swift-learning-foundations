//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Leandro Motta Junior on 12/12/25.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand menu; swipe from the left edge to show ir")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
