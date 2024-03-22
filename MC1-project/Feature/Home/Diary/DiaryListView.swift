//
//  DiaryListView.swift
//  MC1-project
//
//  Created by 이정동 on 3/21/24.
//

import SwiftUI

struct DiaryListView: View {
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    

    var body: some View {
        
        VStack(spacing: 0) {
            CustomNavigationBar()
            
            ScrollView {
                TitleView()
                    .padding(10)
                
                LazyVGrid(columns: columns) {
                    ForEach((0...19), id: \.self) { _ in
                        Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                            .cornerRadius(15)
                            .frame(height: 180)
                            .padding(5)
                        
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(
                Color.bg.ignoresSafeArea(.all)
            )
            .overlay {
                CircleButtonView()
                    .padding(20)
                
            }
        }
        
        
        
    }
}


fileprivate struct TitleView: View {
    
    fileprivate var body: some View {
        HStack {
            Text("기록 리스트")
                .font(.system(size: 40, weight: .bold))
                .foregroundStyle(.wh)
            
            Spacer()
        }
    }
}


fileprivate struct CircleButtonView: View {
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                
                NavigationLink {
                    Text("test")
                } label: {
                    ZStack {
                        
                        Circle()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.org)
                        Image(systemName: "plus")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(Color.wh)
                    }
                }
                
                
                
            }
        }
    }
}

#Preview {
    DiaryListView()
}
