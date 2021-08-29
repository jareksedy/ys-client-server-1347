//
//  Extensions.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 29.08.2021.
//

import Foundation

// MARK: - Форматирование даты/времени а-ля ВК.

extension Double {
    func getRelativeDateStringFromUTC() -> String {
        
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter.string(from: date)
    }
}

// MARK: - Форматирование даты/времени в соответствие с локалью ru_RU.

extension Double {
    func getDateStringFromUTC() -> String {
        
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
}

// MARK: - Форматирование целого числа с разбивкой по разрядам (используется в кол-ве подписчиков).

extension Int {
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "RU")
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        return "\(formattedValue)"
    }
}
