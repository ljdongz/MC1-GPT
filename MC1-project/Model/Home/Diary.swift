//
//  Diary.swift
//  MC1-project
//
//  Created by 이정동 on 3/20/24.
//

import Foundation
import SwiftUI

struct Diary: Hashable {
    var id: UUID = UUID()
    var title: String
    var date: String
    var weather: Set<WeatherType>
    var content: String
    var images: [Image]
    
    init(
        title: String = "",
        date: String = "",
        weather: Set<WeatherType> = [],
        content: String = "",
        images: [Image] = []
    ) {
        self.title = title
        self.date = date
        self.weather = weather
        self.content = content
        self.images = images
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum WeatherType: String, CaseIterable {
    case sunny = "1sun.max.fill"
    case cloudy = "2cloud.fill"
    case rain = "3cloud.heavyrain.fill"
    case lightning = "4cloud.bolt.fill"
    case snow = "5cloud.snow.fill"
    case windy = "6wind"
    
    var value: String {
        return self.rawValue[1...]
    }
}


