//
//  DiaryView.swift
//  MC1-project
//
//  Created by 이정동 on 3/23/24.
//

import SwiftUI

struct DiaryView: View {
    
    @EnvironmentObject private var diaryListViewModel: DiaryListViewModel
    @StateObject var diaryViewModel: DiaryViewModel
    @Environment(\.dismiss) private var dismiss
    
    let isCreateMode: Bool
    
    var body: some View {
        VStack {
            CustomNavigationBar()
            
            ScrollView {
                TitleView(diaryViewModel: diaryViewModel)
                    .padding()
                
                WeatherListView(diaryViewModel: diaryViewModel)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                PhotoListView(diaryViewModel: diaryViewModel)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                ContentView(diaryViewModel: diaryViewModel)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                SaveButton(diaryViewModel: diaryViewModel)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
        .background(Color.bg.ignoresSafeArea())
        .alert("저장하시겠습니까?",
               isPresented: $diaryViewModel.isAlert
        ) {
            Button("취소") {
                
            }
            Button("저장") {
                dismiss()
            }
        }
        
    }
}

// MARK: - 제목 입력 화면
fileprivate struct TitleView: View {
    @ObservedObject private var diaryViewModel: DiaryViewModel
    
    init(diaryViewModel: DiaryViewModel) {
        self.diaryViewModel = diaryViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("제목")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.wh)
                Spacer()
            }
            
            TextField(
                "",
                text: $diaryViewModel.diary.title,
                prompt: Text("")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.gr)
            )
            .lineLimit(2)
            .font(.system(size: 20, weight: .semibold))
            .foregroundStyle(.wh)
            .padding()
            .background(.second)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}


// MARK: - 날씨 선택 화면
fileprivate struct WeatherListView: View {
    
    @ObservedObject private var diaryViewModel: DiaryViewModel
    
    init(diaryViewModel: DiaryViewModel) {
        self.diaryViewModel = diaryViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("날씨")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.wh)
                Spacer()
            }
            
            HStack {
                ForEach(WeatherType.allCases, id: \.self) { weather in
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.second)
                            
                        
                        Image(systemName: weather.rawValue)
                            .foregroundStyle(.gr)
                    }
                    
                    
                }
            }
            
        }
    }
}

// MARK: - 사진 리스트 화면
fileprivate struct PhotoListView: View {
    
    @ObservedObject private var diaryViewModel: DiaryViewModel
    
    init(diaryViewModel: DiaryViewModel) {
        self.diaryViewModel = diaryViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("사진")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.wh)
                Spacer()
            }
            
            ZStack {
                Color.second
            }
            .aspectRatio(2, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

// MARK: - 내용 입력 화면
fileprivate struct ContentView: View {
    
    @ObservedObject private var diaryViewModel: DiaryViewModel
    
    init(diaryViewModel: DiaryViewModel) {
        self.diaryViewModel = diaryViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("내용")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.wh)
                Spacer()
            }
            
            TextEditor(text: $diaryViewModel.diary.content)
                .scrollContentBackground(.hidden)
                .background(.second)
                .clipShape(
                    RoundedRectangle(cornerRadius: 15)
                )
                .frame(minHeight: 150)
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .tint(.wh)
        }
    }
}

// MARK: - 저장 버튼
fileprivate struct SaveButton: View {
    
    @ObservedObject private var diaryViewModel: DiaryViewModel
    
    init(diaryViewModel: DiaryViewModel) {
        self.diaryViewModel = diaryViewModel
    }
    
    fileprivate var body: some View {
        HStack {
            Button(
                action: {
                    diaryViewModel.isAlert = true
                },
                label: {
                    HStack {
                        Spacer()
                        Text("저장")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(.wh)
                            .padding()
                        Spacer()
                    }
                    .background(.org)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            })
        }
        
    }
}

#Preview {
    DiaryView(diaryViewModel: DiaryViewModel(diary: Diary()), isCreateMode: true)
}
