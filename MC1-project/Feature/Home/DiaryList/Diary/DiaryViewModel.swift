//
//  DiaryViewModel.swift
//  MC1-project
//
//  Created by 이정동 on 3/23/24.
//

import Foundation
import SwiftUI
import PhotosUI

class DiaryViewModel: ObservableObject {
    
    @Published var diary: Diary
    @Published var isAlert: Bool = false
    @Published var photosPickerItems: [PhotosPickerItem] {
        didSet {
            self.updateImages()
        }
    }
    @Published var isDisable: Bool = true
    @Published var guideQuestionIndex: Int = 0
    
    static let guideQuestions: [String] = [
        "위 사진에서 기억이 나는 장면은 무엇인가요?",
        "오늘 하루 중 가장 기억에 남는 순간은 언제였나요?",
        "오늘 있었던 일 중 꼭 기억하고 싶은 순간은 언제였나요?"
    ]
    
    static let keywords: [String] = [
        "아름답다.",
        "예쁘다",
        "눈부시다",
        "아름답다.",
        "예쁘다",
        "눈부시다"
    ]
    
    init(
        diary: Diary,
        photosPickerItems: [PhotosPickerItem] = []
    ) {
        self.diary = diary
        self.photosPickerItems = photosPickerItems
    }
}

extension DiaryViewModel {
    
    func updateImages() {
        self.diary.images.removeAll()
        
        Task { await loadTransferable() }
    }
    
    func loadTransferable() async {
        
        for item in self.photosPickerItems {
            if let data = try? await item.loadTransferable(type: Data.self) {
                DispatchQueue.main.async {
                    if let uiImage = UIImage(data: data) {
                        let image = Image(uiImage: uiImage)
                        self.diary.images.append(image)
                    }
                }
            }
        }
    }
    
    func checkIsDisable() {
        self.isDisable = (
            diary.title.trimmingCharacters(in: .whitespacesAndNewlines) != "" &&
            diary.weather.count != 0 &&
            diary.images.count != 0 &&
            diary.content.trimmingCharacters(in: .whitespacesAndNewlines) != ""
        ) ? false : true
    }
}
