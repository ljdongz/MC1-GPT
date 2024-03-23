//
//  PlaceView.swift
//  MC1-project
//
//  Created by 이정동 on 3/23/24.
//

import SwiftUI

struct PlaceView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @StateObject var placeViewModel: PlaceViewModel
    
    var body: some View {
        ZStack {
            
            Color.bg.ignoresSafeArea()
            
            VStack {
                CustomNavigationBar()
                
                TitleView(placeViewModel: placeViewModel)
                    .padding()
                
                PeriodView(placeViewModel: placeViewModel)
                    .padding(.horizontal)
                    
                
                SaveButton(placeViewModel: placeViewModel)
                    .padding()
                Spacer()
            }
        }
        .alert("저장하시겠습니까?",
               isPresented: $placeViewModel.isAlert
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
    @ObservedObject private var placeViewModel: PlaceViewModel
    
    init(placeViewModel: PlaceViewModel) {
        self.placeViewModel = placeViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("여행 타이틀")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.wh)
                Spacer()
            }
            
            TextField(
                "",
                text: $placeViewModel.title,
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

// MARK: - 여힝 기간 설정 화면
fileprivate struct PeriodView: View {
    
    @ObservedObject private var placeViewModel: PlaceViewModel
    
    init(placeViewModel: PlaceViewModel) {
        self.placeViewModel = placeViewModel
    }
    
    fileprivate var body: some View {
        VStack {
            HStack {
                Text("기간")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.wh)
                Spacer()
            }
            
            
            HStack {
                Spacer()
                DatePicker(
                    "",
                    selection: $placeViewModel.startDate,
                    displayedComponents: [.date]
                )
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal)
                .padding(.vertical, 5)
                .background(.clear)
                .datePickerStyle(.compact)
                .labelsHidden()
                .colorInvert()
                
                Text("~")
                    .foregroundStyle(.wh)
                    .font(.system(size: 20, weight: .semibold))
            
                DatePicker(
                    "",
                    selection: $placeViewModel.endDate,
                    in: placeViewModel.startDate...,
                    displayedComponents: [.date]
                )
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal)
                .padding(.vertical)
                .background(.clear)
                .datePickerStyle(.compact)
                .labelsHidden()
                .colorInvert()
                
                Spacer()
            }
            .background(.second)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
        }
    }
}

// MARK: - 저장 버튼
fileprivate struct SaveButton: View {
    
    @ObservedObject private var placeViewModel: PlaceViewModel
    
    init(placeViewModel: PlaceViewModel) {
        self.placeViewModel = placeViewModel
    }
    
    fileprivate var body: some View {
        HStack {
            Button(
                action: {
                    placeViewModel.isAlert = true
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
    PlaceView(placeViewModel: PlaceViewModel())
        .environmentObject(HomeViewModel())
}