//
//  DateConverter.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2/2/24.
//

import Foundation

class DateConverter {
    static func convertDateString(_ dateString: String) -> String? {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy.MM.dd"

        if let date = inputFormatter.date(from: dateString) {
            let formattedDate = outputFormatter.string(from: date)
            return formattedDate
        } else {
            return nil
        }
    }
}
