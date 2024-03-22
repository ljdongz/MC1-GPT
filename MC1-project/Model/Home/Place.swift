//
//  Place.swift
//  MC1-project
//
//  Created by 이정동 on 3/20/24.
//

import Foundation

struct Place: Hashable {
    var name: String
    var startDate: Date
    var endDate: Date
    var diaries: [Diary] = []
}
