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
