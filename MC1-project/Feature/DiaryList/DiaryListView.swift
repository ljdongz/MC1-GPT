//
//  DiaryListView.swift
//  MC1-project
//
//  Created by 이정동 on 3/21/24.
//

import SwiftUI

struct DiaryListView: View {
    
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @StateObject var diaryListViewModel: DiaryListViewModel

    var body: some View {
        
        VStack(spacing: 0) {
            CustomNavigationBar(title: diaryListViewModel.place.name)
            
            ScrollView {
                LazyVStack(content: {
                    ForEach(diaryListViewModel.place.diaries, id: \.self) { diary in
                        DiaryListCellView(diary: diary)
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

fileprivate struct DiaryListCellView: View {
    
    let diary: Diary
    
    init(diary: Diary) {
        self.diary = diary
    }
    
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
                Text(diary.date)
                    .foregroundStyle(.gr)
                    .font(.system(size: 14, weight: .bold))
                
                Text(diary.title)
                    .foregroundStyle(.gr)
                    .font(.system(size: 40, weight: .medium))
                
                Text(diary.content)
                    .foregroundStyle(.gr)
                    .font(.system(size: 16, weight: .medium))
                
                Image(diary.images[0])
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
    DiaryListView(
        diaryListViewModel: .init(
            place: Place(
                name: "서울",
                startDate: "24.01.01",
                endDate: "24.01.03",
                diaries: [
                    Diary(
                        title: "1번",
                        date: "24.01.01",
                        weather: [.sunny],
                        content: "content\ncontentconteontcono\nocnno",
                        images: [
                            .airplane
                        ]
                    ),
                    Diary(
                        title: "2번",
                        date: "24.01.02",
                        weather: [.sunny],
                        content: "포항항항하아항하앟아항항",
                        images: [
                            .sample0
                        ]
                    ),
                    Diary(
                        title: "3번",
                        date: "24.01.03",
                        weather: [.sunny],
                        content: "content\ncon\no\noo\nocnno",
                        images: [
                            .sample1
                        ]
                    )
                    ,Diary(
                        title: "4번",
                        date: "24.01.04",
                        weather: [.sunny],
                        content: "contento",
                        images: [
                            .sample2
                        ]
                    )
                ]
            )
        )
    )
}

