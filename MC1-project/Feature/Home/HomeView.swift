//
//  ContentView.swift
//  MC1-project
//
//  Created by 이정동 on 3/20/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            
            SearchBar(viewModel: homeViewModel)
                .padding()
            
            ScrollView {
                OngoingView(viewModel: homeViewModel)
                    .padding()
                
                
                LazyVGrid(columns: homeViewModel.columns) {
                    ForEach(homeViewModel.currentPlaces, id: \.self) { place in
                        PlaceView(viewModel: homeViewModel, place: place)
                    }
                }
                .padding(.horizontal)
                .animation(.spring, value: homeViewModel.currentPlaces)
            }
            .frame(maxWidth: .infinity)
            .scrollIndicators(.hidden)
            
            .overlay {
                CircleButtonView()
                    .padding(20)
                
            }
        }
        .background(
            Color.bg.ignoresSafeArea(.all)
        )
        
        
    }
}

// MARK: - 서치 바
fileprivate struct SearchBar: View {
    @ObservedObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    fileprivate var body: some View {
        HStack {
            Image(._1_1)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "magnifyingglass")
                        .padding(.leading, 10)
                        .foregroundStyle(.wh)
                        .font(.system(size: 20, weight: .medium))
                    
                    TextField(
                        "",
                        text: $viewModel.text,
                        prompt: Text("여행지 검색하기").foregroundStyle(.gr)
                    )
                    .foregroundStyle(.wh)
                    .font(.system(size: 16, weight: .medium))
                }
                Spacer()
            }
            .background(.second)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .background(.bg)
        .frame(height: 50)
        
    }
}

// MARK: - 안내 뷰
fileprivate struct AnnouncementView: View {
    
    fileprivate var body: some View {
        ZStack {
            Image(.sample0)
                .resizable()
                .opacity(0.25)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(height: 100)
                .shadow(color: .black, radius: 1, x: 5, y: 5)
            
        }
    }
}

// MARK: - 진행중인 여행
fileprivate struct OngoingView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    fileprivate var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundStyle(.bg)
                .frame(height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black, radius: 1, x: 5, y: 5)
                .opacity(0.25)
            
            Image(.sample0)
                .resizable()
                .opacity(0.25)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(height: 130)
            
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .lastTextBaseline) {
                        Text("포항")
                            .font(.system(size: 40, weight: .bold))
                            .foregroundStyle(.wh)
                        
                        Spacer()
                            .frame(width: 10)
                        
                        Text("여행중")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.wh)
                    }
                    
                    Text("24.03.02 ~ 24.12.13")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.gr)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 25, weight: .medium))
                    .foregroundStyle(.wh)
            }
            .padding(20)
        }
        
    }
}

// MARK: - 여행지
fileprivate struct PlaceView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    
    let place: Place
    
    init(viewModel: HomeViewModel, place: Place) {
        self.viewModel = viewModel
        self.place = place
    }
    
    fileprivate var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.bg)
                .frame(height: 170)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black, radius: 1, x: 5, y: 5)
                .opacity(0.25)
            
            Image(place.diaries[0].images[0])
                .resizable()
                .opacity(0.25)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .frame(height: 170)
                
            
            
            VStack(alignment: .center) {
                
                Text(place.name)
                    .font(.system(size: 25, weight: .bold))
                    .foregroundStyle(.wh)
                
                Text("24.03.02 ~ 24.12.13")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.gr)
            }
        }
        
    }
}

// MARK: - 여행지 생성 버튼
fileprivate struct CircleButtonView: View {
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                
                NavigationLink {
                    DiaryListView()
                        .navigationBarBackButtonHidden()
                } label: {
                    ZStack {
                        
                        Circle()
                            .frame(width: 80, height: 80)
                            .foregroundStyle(Color.org)
                        Image(systemName: "plus")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundStyle(Color.wh)
                    }
                    .opacity(0.9)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
