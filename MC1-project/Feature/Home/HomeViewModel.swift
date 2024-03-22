//
//  PlaceListViewModel.swift
//  MC1-project
//
//  Created by 이정동 on 3/20/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var places: [Place]
    @Published var currentPlaces: [Place]
    @Published var columns: [GridItem]
    @Published var text: String {
        didSet {
                if text.trimmingCharacters(in: .whitespaces) == "" {
                    currentPlaces = places
                } else {
                    currentPlaces = places.filter { $0.name.contains(text)}
                }
        }
    }
    
    init() {
        self.places = []
        self.currentPlaces = []
        self.columns = Array(repeating: .init(.flexible()), count: 2)
        self.text = ""
        
        makeDummy()
    }
    
    func makeDummy() {
        self.places = [
            .init(name: "국내", startDate: .now, endDate: .now, diaries: [.init(images: [.sample0])]),
            .init(name: "국내", startDate: .now, endDate: .now, diaries: [.init(images: [.sample1])]),
            .init(name: "해외", startDate: .now, endDate: .now, diaries: [.init(images: [.sample2])]),
            .init(name: "해외", startDate: .now, endDate: .now, diaries: [.init(images: [.sample3])]),
            .init(name: "국해", startDate: .now, endDate: .now, diaries: [.init(images: [.sample4])]),
            .init(name: "국해", startDate: .now, endDate: .now, diaries: [.init(images: [.sample5])]),
        ]
        
        self.currentPlaces = places
    }
    
    func changeColumns(_ count: Int) {
        self.columns = Array(repeating: .init(.flexible()), count: count)
    }
}
