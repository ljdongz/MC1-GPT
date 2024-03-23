//
//  DiaryViewModel.swift
//  MC1-project
//
//  Created by 이정동 on 3/23/24.
//

import Foundation

class DiaryViewModel: ObservableObject {
    @Published var diary: Diary
    @Published var isAlert: Bool
    
    init(diary: Diary, isAlert: Bool = false) {
        self.diary = diary
        self.isAlert = isAlert
    }
}
