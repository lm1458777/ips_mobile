//
//  Formatter.swift
//  EquationSolver
//
//  Created by maksim.levakov on 3/2/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import Foundation

class Formatter {
    private let enLocale = Locale(identifier: "en_US")
    private let numberFormatter: NumberFormatter

    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
    }

    func toString(_ d: Double) -> String {
        return numberFormatter.string(from: NSNumber(value: d)) ?? ""
    }

    func parseDouble(_ s: String) -> Double? {
        let currentLocale = Locale.current
        if let d = parseDouble(s, locale: currentLocale) {
            return d
        }

        if currentLocale != enLocale {
            if let d = parseDouble(s, locale: enLocale) {
                return d
            }
        }

        return nil
    }

    func parseDouble(_ s: String, locale: Locale) -> Double? {
        let currentLocale = numberFormatter.locale
        numberFormatter.locale = locale
        defer {
            numberFormatter.locale = locale
        }
        return numberFormatter.number(from: s)?.doubleValue
    }
}
