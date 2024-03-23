//
//  PlaceViewModel.swift
//  MC1-project
//
//  Created by 이정동 on 3/23/24.
//

import Foundation

class PlaceViewModel: ObservableObject {
    @Published var title: String
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var isAlert: Bool
    
    init(
        title: String = "",
        startDate: Date = Date(),
        endDate: Date = Date(),
        isAlert: Bool = false
    ) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.isAlert = isAlert
    }
}

