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
                //OngoingView(viewModel: homeViewModel)
                AnnouncementView()
                    .padding()
                
                
                LazyVGrid(columns: homeViewModel.columns) {
                    ForEach(
                        homeViewModel.places.filter {
                            // text != "" 인 경우는 text가 포함된 여행지만 필터링
                            // text == ""인 경우 모든 여행지 가져오기
                            $0.name.contains(homeViewModel.text) ||
                            homeViewModel.text == ""
                        }, id: \.self
                    ) { place in
                        PlaceCellView(viewModel: homeViewModel, place: place)
                    }
                }
                .padding(.horizontal)
                .animation(.spring, value: homeViewModel.places)
                .animation(.spring, value: homeViewModel.text)
            }
            .frame(maxWidth: .infinity)
            .scrollIndicators(.hidden)
            .overlay {
                CircleButtonView(homeViewModel: homeViewModel)
                    .padding(.vertical, 50)
                    .padding(.horizontal, 25)
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
            
            Button(
                action: { },
                label: {
                    ZStack {
                        Color.second
                        
                        Image(systemName: "slider.horizontal.3")
                            .foregroundStyle(.wh)
                            .font(.system(size: 20, weight: .medium))
                        
                        Picker("", selection: $viewModel.sortType) {
                            ForEach(HomeViewModel.SortType.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(.clear)
                    }
                    .frame(width: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                })
        }
        .background(.bg)
        .frame(height: 50)
        
    }
}

// MARK: - 안내 뷰
fileprivate struct AnnouncementView: View {
    
    fileprivate var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundStyle(.bg)
                .frame(height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: .black, radius: 1, x: 5, y: 5)
                .opacity(0.4)
            
            Image(.airplane)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.4)
                .frame(height: 130)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack(alignment: .leading, spacing: 10) {
                Text("새로운 여행을 계획 해보세요.")
                    .font(.system(size: 24, weight: .bold))
                Text("새로운 경험이 여러분을 기다리고 있어요.")
                    .font(.system(size: 18, weight: .semibold))
            }
            .foregroundStyle(.wh)
            
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
                .opacity(0.4)
            
            
            Image(.sample0)
                .resizable()
                .opacity(0.4)
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
fileprivate struct PlaceCellView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    let place: Place
    
    init(viewModel: HomeViewModel, place: Place) {
        self.viewModel = viewModel
        self.place = place
    }
    
    fileprivate var body: some View {
        NavigationLink {
            DiaryListView(
                diaryListViewModel: DiaryListViewModel(place: place)
            )
            .environmentObject(viewModel)
            .navigationBarBackButtonHidden()
        } label: {
            ZStack {
                Rectangle()
                    .foregroundStyle(.bg)
                    .frame(height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(color: .black, radius: 1, x: 5, y: 5)
                    .opacity(0.4)
                
                place.thumbnail
                    .resizable()
                    .opacity(0.4)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(height: 170)
                
                
                
                VStack(alignment: .center) {
                    
                    Text(place.name)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.wh)
                    
                    Text("\(place.startDate) ~ \(place.endDate)")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.wh)
                }
            }
        }
    }
}

// MARK: - 여행지 생성 버튼
fileprivate struct CircleButtonView: View {
    
    @ObservedObject private var homeViewModel: HomeViewModel
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                NavigationLink {
                    PlaceView(placeViewModel: PlaceViewModel(), isCreateMode: true)
                        .environmentObject(homeViewModel)
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
