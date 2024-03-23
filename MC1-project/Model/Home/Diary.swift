//
//  Diary.swift
//  MC1-project
//
//  Created by 이정동 on 3/20/24.
//

import Foundation
import SwiftUI

struct Diary: Hashable {
    var title: String
    var date: String
    var weather: [WeatherType]
    var content: String
    var images: [ImageResource]
}

enum WeatherType: String {
    case sunny = "맑음"
    case cloudy = "흐림"
    case rain = "비"
    case windy = "바람"
    case lightning = "번개"
    case snow = "눈"
}
