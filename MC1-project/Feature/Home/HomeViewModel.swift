//
//  PlaceListViewModel.swift
//  MC1-project
//
//  Created by 이정동 on 3/20/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    enum SortType: String, CaseIterable {
        case name = "이름순"
        case recent = "최신순"
        case longest = "긴 여행순"
        case shortest = "짧은 여행순"
        case count = "일지개수순"
    }
    
    @Published var places: [Place]
    @Published var columns: [GridItem]
    @Published var text: String
    @Published var sortType: SortType {
        didSet {
            sortPlaces(self.sortType)
        }
    }
    
    init() {
        self.places = []
        self.columns = Array(repeating: .init(.flexible()), count: 2)
        self.text = ""
        sortType = .recent
        
        makeDummy()
    }
    
    func makeDummy() {
        self.places = [
            Place(
                name: "서울",
                startDate: "24.02.11",
                endDate: "24.02.21",
                diaries: [
                    Diary(title: "서울에 도착하다!", date: "24.02.11", weather: [.sunny], content: "너무너무 좋다\n또 오고싶다 ^_^", images: [
                        .init(.sample0), .init(.sample1)
                    ])
                ]
            ),
            Place(
                name: "포항",
                startDate: "24.03.01",
                endDate: "24.03.11",
                diaries: [
                    Diary(title: "포항 살이 시작!", date: "24.03.01", weather: [.cloudy], content: "애플 아카데미 시작..!", images: [.init(.sample1)])
                ]
            ),
            Place(
                name: "경주",
                startDate: "23.06.06",
                endDate: "23.06.11",
                diaries: [
                    Diary(title: "경주 도착하다!", date: "24.06.06", weather: [.rain, .lightning], content: "너무너무 좋다\n또 오고싶다 ^_^", images: [.init(.sample1), .init(.sample2)])
                ]
            ),
            Place(
                name: "도쿄",
                startDate: "21.02.11",
                endDate: "21.02.20",
                diaries: [
                    Diary(title: "첫 해외여행~", date: "24.02.11", weather: [.sunny], content: "너무너무 좋다\n또 오고싶다 ^_^", images: [.init(.sample3), .init(.sample4)])
                ]
            ),
            Place(
                name: "강릉",
                startDate: "22.04.01",
                endDate: "22.04.05",
                diaries: [
                    Diary(title: "바다 구경한 날", date: "24.04.03", weather: [.sunny], content: "너무너무 좋다\n또 오고싶다 ^_^", images: [.init(.sample5), .init(.sample4)])
                ]
            ),Place(
                name: "제주도",
                startDate: "23.11.11",
                endDate: "23.11.16",
                diaries: [
                    Diary(title: "제주 좋다~", date: "23.11.11", weather: [.snow], content: "너무너무 좋다\n또 오고싶다 ^_^", images: [.init(.sample3), .init(.sample2)])
                ]
            )
        ]
    }
    
    
}


extension HomeViewModel {
    func changeColumns(_ count: Int) {
        self.columns = Array(repeating: .init(.flexible()), count: count)
    }
    
    func sortPlaces(_ type: SortType) {
        switch type {
        case .name:
            places.sort { $0.name < $1.name }
        case .recent:
            places.sort { $0.startDate > $1.startDate }
        case .longest:
            print()
        case .shortest:
            print()
        case .count:
            places.sort { $0.diaries.count > $1.diaries.count }
        }
    }
    
    func appendPlace(_ place: Place) {
        self.places.append(place)
        sortPlaces(self.sortType)
    }
    
    func appendDiary(_ diary: Diary, at place: Place) {
        if let index = places.firstIndex(of: place) {
            places[index].diaries.append(diary)
            places[index].diaries.sort { $0.date < $1.date }
        }
    }
    
    //func updateDiary(_)
}
