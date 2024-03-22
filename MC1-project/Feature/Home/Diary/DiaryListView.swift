//
//  DiaryListView.swift
//  MC1-project
//
//  Created by 이정동 on 3/21/24.
//

import SwiftUI

struct DiaryListView: View {
    
    @StateObject private var diaryListViewModel = DiaryListViewModel()
    @ObservedObject private var homeViewModel: HomeViewModel
    
    let place: Place

    
    init(homeViewModel: HomeViewModel, place: Place) {
        self.homeViewModel = homeViewModel
        self.place = place
    }

    var body: some View {
        
        VStack(spacing: 0) {
            CustomNavigationBar(title: "경주")
            
            ScrollView {
                LazyVStack(content: {
                    ForEach(1...10, id: \.self) { count in
                        DiaryView()
                            .padding(.horizontal, 20)
                    }
                })
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity)
            .background(
                Color.bg.ignoresSafeArea(.all)
            )
            .overlay {
                CircleButtonView()
                    .padding(.bottom, 50)
                    .padding(.horizontal, 25)
            }
        }
    }
}

fileprivate struct DiaryView: View {
    
    fileprivate var body: some View {
        HStack(spacing: 20) {
            VStack {
                
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundStyle(.second)
                
                Rectangle()
                    .frame(width: 2, height: .infinity)
                    .foregroundStyle(.second)
                    .clipShape(RoundedRectangle(cornerRadius: 1))
            }
            
            VStack(alignment: .leading) {
                Text("24.01.01")
                    .foregroundStyle(.gr)
                    .font(.system(size: 14, weight: .bold))
                
                Text("타이틀")
                    .foregroundStyle(.gr)
                    .font(.system(size: 40, weight: .medium))
                
                Text("Description")
                    .foregroundStyle(.gr)
                    .font(.system(size: 20, weight: .medium))
                
                Image(.airplane)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                
                
             
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(.second)
                    .clipShape(RoundedRectangle(cornerRadius: 1))
                    .padding(.vertical, 20)
            }
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
                .opacity(0.9)
            }
        }
        
    }
}

#Preview {
    DiaryListView(homeViewModel: HomeViewModel(), place: Place(name: "서울", startDate: "24.01.01", endDate: "24.01.03", diaries: []))
}
