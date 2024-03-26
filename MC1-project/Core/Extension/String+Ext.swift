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

// MARK: - subscript
extension String {
    subscript(index: Range<Int>) -> Self {
        get {
            let start = self.index(self.startIndex, offsetBy: index.lowerBound)
            let end = self.index(self.startIndex, offsetBy: index.upperBound)
            
            return String(self[start..<end])
        }
    }
    
    subscript(index: ClosedRange<Int>) -> Self {
        get {
            let start = self.index(self.startIndex, offsetBy: index.lowerBound)
            let end = self.index(self.startIndex, offsetBy: index.upperBound)
            
            return String(self[start...end])
        }
    }
    
    subscript(index: PartialRangeFrom<Int>) -> Self {
        get {
            let start = self.index(self.startIndex, offsetBy: index.lowerBound)
            
            return String(self[start..<self.endIndex])
        }
    }
}
