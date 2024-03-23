//
//  Place.swift
//  MC1-project
//
//  Created by 이정동 on 3/20/24.
//

import Foundation
import SwiftUI

struct Place: Hashable {
    var id: UUID = UUID()
    var name: String
    var startDate: String
    var endDate: String
    var thumbnail: ImageResource = .airplane
    var diaries: [Diary] = []
}
