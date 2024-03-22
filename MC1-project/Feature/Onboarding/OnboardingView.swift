//
//  OnboardingView.swift
//  MC1-project
//
//  Created by 이정동 on 3/20/24.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    HomeView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("시작하기")
                }

            }
        }
    }
}


#Preview {
    OnboardingView()
}
