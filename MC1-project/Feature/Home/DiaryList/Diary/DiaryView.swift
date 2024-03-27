//
//  DiaryView.swift
//  MC1-project
//
//  Created by 이정동 on 3/23/24.
//

import SwiftUI
import PhotosUI

struct DiaryView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
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
                
                DateView(
                    diaryViewModel: diaryViewModel,
                    startDate: diaryListViewModel.place.startDate.convertToDate(),
                    endDate: diaryListViewModel.place.endDate.convertToDate()
                )
                .padding(.horizontal)
                .padding(.bottom)
                
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
                homeViewModel.appendDiary(
                    diaryViewModel.diary,
                    at: diaryListViewModel.place
                )
                
                diaryListViewModel.appendDiary(diaryViewModel.diary)
                
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

// MARK: - 날짜 선택 화면
fileprivate struct DateView: View {
    
    @ObservedObject private var diaryViewModel: DiaryViewModel
    @State private var selectedDate: Date
    let startDate: Date
    let endDate: Date
    
    init(
        diaryViewModel: DiaryViewModel,
        startDate: Date,
        endDate: Date
    ) {
        self.diaryViewModel = diaryViewModel
        self.startDate = startDate
        self.endDate = endDate
        self.selectedDate = startDate
    }
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("날짜")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.wh)
                Spacer()
            }
            
            DatePicker(
                "",
                selection: $selectedDate,
                in: startDate...endDate,
                displayedComponents: .date
            )
            .font(.system(size: 16, weight: .semibold))
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(.clear)
            .datePickerStyle(.compact)
            .labelsHidden()
            .colorInvert()
            
        }
        .onAppear {
            diaryViewModel.diary.date = startDate.convertToString()
        }
        .onChange(of: selectedDate) { _, _ in
            diaryViewModel.diary.date = selectedDate.convertToString()
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
                ForEach(WeatherType.allCases.sorted { $0.rawValue < $1.rawValue }, id: \.self) { weather in
                    WeatherButton(
                        diaryViewModel: diaryViewModel,
                        weatherType: weather
                    )
                }
            }
            
        }
    }
}

// MARK: - 날씨 선택 버튼
fileprivate struct WeatherButton: View {
    
    @ObservedObject private var diaryViewModel: DiaryViewModel
    let weatherType: WeatherType
    
    init(diaryViewModel: DiaryViewModel, weatherType: WeatherType) {
        self.diaryViewModel = diaryViewModel
        self.weatherType = weatherType
    }
    
    fileprivate var body: some View {
        VStack {
            Button(
                action: {
                    if diaryViewModel.diary.weather
                        .contains(weatherType) {
                        diaryViewModel.diary.weather.remove(weatherType)
                    } else {
                        diaryViewModel.diary.weather.insert(weatherType)
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(
                                diaryViewModel.diary.weather.contains(weatherType) ? .org : .second
                            )
                        
                        Image(systemName: weatherType.value)
                            .foregroundStyle(.gr)
                    }
                })
        }
    }
}

// MARK: - 사진 리스트 화면
fileprivate struct PhotoListView: View {
    
    @ObservedObject private var diaryViewModel: DiaryViewModel
    @State private var selectedIndex = 0
    
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
                Text(
                    diaryViewModel.diary.images.isEmpty ?
                    "여행에서 촬영한 사진을 추가해보세요." : " "
                )
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.gray)
                
                TabView(selection: $selectedIndex) {
                    ForEach(
                        0..<diaryViewModel.diary.images.count,
                        id: \.self) { index in
                            diaryViewModel.diary.images[index]
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity)
                        }
                }
                .tabViewStyle(.page)
                
            }
            .aspectRatio(1.5, contentMode: .fill)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(
                        .second,
                        lineWidth: !diaryViewModel.diary.images.isEmpty ? 0 : 5
                    )
            )
            
            if !diaryViewModel.diary.images.isEmpty {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(DiaryViewModel.keywords, id: \.self) { keyword in
                            KeywordTagView(keyword: keyword)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            
            
            PhotosPicker(
                selection: $diaryViewModel.photosPickerItems,
                maxSelectionCount: 5,
                selectionBehavior: .ordered
            ) {
                Text("추가")
                    .frame(width: 200, height: 40)
                    .background(.second)
                    .foregroundStyle(.wh)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
        
    }
}

fileprivate struct KeywordTagView: View {
    
    let keyword: String
    
    fileprivate var body: some View {
        HStack {
            Text("# \(keyword)")
                .foregroundStyle(.gr)
                .font(.system(size: 16, weight: .semibold))
        }
        .padding(8)
        .background(.second)
        .clipShape(RoundedRectangle(cornerRadius: 10))
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
            
            HStack {
                Text("• \(DiaryViewModel.guideQuestions[diaryViewModel.guideQuestionIndex % 3])")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 5)
                Spacer()
                Button(
                    action: {
                        withAnimation {
                            diaryViewModel.guideQuestionIndex += 1
                        }
                    },
                    label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                })
                .padding(.horizontal, 15)
            }
            .padding(.vertical, 5)
            
            TextEditor(text: $diaryViewModel.diary.content)
                .scrollContentBackground(.hidden)
                .background(.second)
                .clipShape(
                    RoundedRectangle(cornerRadius: 15)
                )
                .frame(minHeight: 150)
                .fixedSize(horizontal: false, vertical: true)
                .tint(.wh)
                .foregroundStyle(.wh)
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
                    .background(diaryViewModel.isDisable ? .gray : .org)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
            )
            .disabled(diaryViewModel.isDisable)
            
        }
        .onChange(of: diaryViewModel.diary) {
            diaryViewModel.checkIsDisable()
        }
        
    }
}

#Preview {
    DiaryView(
        diaryViewModel: DiaryViewModel(
            diary: Diary(title: "", date: "24.01.01", weather: [], content: "", images: [])
        ),
        isCreateMode: true)
    .environmentObject(DiaryListViewModel(place: Place(name: "경주", startDate: "24.01.01", endDate: "24.01.03")))
}
