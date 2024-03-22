//
//  String+Ext.swift
//  MC1-project
//
//  Created by 이정동 on 3/22/24.
//

import Foundation

extension String {
    func convertToDate() -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = .init(identifier: "UTC")
        formatter.dateFormat = "yy.MM.dd"
        return formatter.date(from: self)!
    }
}
