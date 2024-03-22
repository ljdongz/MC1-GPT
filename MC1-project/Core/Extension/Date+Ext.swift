//
//  Date+Ext.swift
//  MC1-project
//
//  Created by 이정동 on 3/22/24.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .init(identifier: "UTC")
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: self)
    }
}
