//
//  Article.swift
//  Test
//
//  Created by Evan Su on 18/3/20.
//  Copyright © 2020 techtask. All rights reserved.
//

import Foundation

public struct Article {
    let title: String
    let abstract: String
    let writer: String
    let url: String
    let timestamp: Int64
}

extension Article: Equatable {
    public static func == (lhs: Article, rhs: Article) -> Bool {
        return  lhs.title == rhs.title &&
                lhs.abstract == rhs.abstract &&
                lhs.writer == rhs.writer &&
                lhs.url == rhs.url &&
                lhs.timestamp == rhs.timestamp
    }
    
    public var displayDateTime: String {
        let date = Date(timeIntervalSince1970: Double(self.timestamp)/1000.0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMMM d, yyyy - h:mm a"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
