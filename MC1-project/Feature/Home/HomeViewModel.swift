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
        case recent = "최신순"
        case name = "이름순"
        case longest = "긴 여행순"
        case shortest = "짧은 여행순"
        //case count = "일지 개수순"
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
                name: "서울 호캉스",
                startDate: "24.02.11",
                endDate: "24.02.12",
                thumbnail: Image(.seoul),
                diaries: [
                    Diary(title: "서울에 도착하다!", date: "24.02.11", weather: [.sunny], content: "너무너무 좋다\n또 오고싶다 ^_^", images: [
                        .init(.sample0), .init(.sample1)
                    ])
                ]
            ),
            Place(
                name: "첫 해외여행 미국!",
                startDate: "24.03.01",
                endDate: "24.03.15",
                thumbnail: Image(.USA),
                diaries: [
                    Diary(title: "포항 살이 시작!", date: "24.03.01", weather: [.cloudy], content: "애플 아카데미 시작..!", images: [.init(.sample1)])
                ]
            ),
            Place(
                name: "나 홀로 경주 여행",
                startDate: "23.06.06",
                endDate: "23.06.08",
                thumbnail: Image(.gyeongju),
                diaries: [
                    Diary(
                        title: "경주 도착하다!",
                        date: "24.06.06",
                        weather: [.windy, .cloudy, .sunny],
                        content: "혼자 여행하는 첫 여행의 첫째 날이었다!\n도착하자마자 한우물회로 배를 배불리 채웠다.\n경주 식물원에 들렸다가 경주 타워 그리고 미술관을 갔다.\n카메라를 사고 첫 여행이었는데 사진을 많이 찍을 수 있어서 좋았다 ^_^",
                        images: [
                            .init(.first1),
                            .init(.first2),
                            .init(.first3),
                            .init(.first4),
                            .init(.first5)
                        ]
                    ),
                    Diary(
                        title: "바다 구경하러~",
                        date: "24.06.07",
                        weather: [.cloudy, .sunny],
                        content: "오늘은 경주 바다를 구경하는 날이다~!\n오랜만에 바닷가를 간거였는데 기분이 맑아지는 기분이라 너무 잘 왔다는 생각이 들었다.",
                        images: [
                            .init(.second1),
                            .init(.second2),
                            .init(.second3)
                        ]
                    ),
                    Diary(
                        title: "황리단길을 마지막으로",
                        date: "24.06.08",
                        weather: [.sunny],
                        content: "여행 마지막 날은 황리단길로 마무리를 했다.\n가서 경주 10원빵을 먹었다.😋 \n초등학생 때 처음 봤던 첨성대를 오늘 다시 봤는데, 색다른 기분이 들면서 어릴 때가 생각이 났다.\n종종 왔던 장소를 재방문하면서 추억을 되새겨 보기로 했다.",
                        images: [
                            .init(.third1),
                            .init(.third2),
                            .init(.third3),
                            .init(.third4)
                        ]
                    )
                ]
            ),
            Place(
                name: "도쿄 여행",
                startDate: "21.02.11",
                endDate: "21.02.20",
                thumbnail: Image(.tokyo),
                diaries: [
                    Diary(title: "첫 해외여행~", date: "24.02.11", weather: [.sunny], content: "너무너무 좋다\n또 오고싶다 ^_^", images: [.init(.sample3), .init(.sample4)])
                ]
            ),
            Place(
                name: "강릉",
                startDate: "22.04.01",
                endDate: "22.04.05",
                thumbnail: Image(.gangneung),
                diaries: [
                    Diary(title: "바다 구경한 날", date: "24.04.03", weather: [.sunny], content: "너무너무 좋다\n또 오고싶다 ^_^", images: [.init(.sample5), .init(.sample4)])
                ]
            ),Place(
                name: "제주도 1달 살이",
                startDate: "23.11.11",
                endDate: "23.12.16",
                thumbnail: Image(.jeju),
                diaries: [
                    Diary(title: "제주 좋다~", date: "23.11.11", weather: [.snow], content: "너무너무 좋다\n또 오고싶다 ^_^", images: [.init(.sample3), .init(.sample2)]),
                    Diary(title: "제주 좋다~", date: "23.11.11", weather: [.snow], content: "너무너무 좋다\n또 오고싶다 ^_^", images: [.init(.sample3), .init(.sample2)])
                ]
            )
        ]
        
        self.sortPlaces(.recent)
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
            places.sort {
                let l = getPeriodOfTravel(from: $0.startDate, to: $0.endDate)
                let r = getPeriodOfTravel(from: $1.startDate, to: $1.endDate)
                return l > r
            }
        case .shortest:
            places.sort {
                let l = getPeriodOfTravel(from: $0.startDate, to: $0.endDate)
                let r = getPeriodOfTravel(from: $1.startDate, to: $1.endDate)
                return l < r
            }
//        case .count:
//            places.sort { $0.diaries.count > $1.diaries.count }
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
    
    
    func getPeriodOfTravel(from: String, to: String) -> TimeInterval {
        let fromDate = from.convertToDate()
        let toDate = to.convertToDate()
        return toDate.timeIntervalSince(fromDate)
    }
    
    //func updateDiary(_)
}
