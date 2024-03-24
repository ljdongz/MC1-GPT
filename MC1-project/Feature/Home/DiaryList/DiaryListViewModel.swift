//
//  DiaryListViewModel.swift
//  MC1-project
//
//  Created by 이정동 on 3/22/24.
//

import Foundation

class DiaryListViewModel: ObservableObject {
    @Published var place: Place
    
    init(place: Place) {
        self.place = place
    }
}

extension DiaryListViewModel {
    func appendDiary(_ diary: Diary) {
        self.place.diaries.append(diary)
        place.diaries.sort {
            $0.date < $1.date
        }
    }
}
