//
//  Double+Comparison.swift
//  EquationSolver
//
//  Created by maksim.levakov on 2/25/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import Foundation

extension Double {
    func precised(_ value: Int = 1) -> Double {
        let offset = pow(10, Double(value))
        return (self * offset).rounded() / offset
    }

    static func equal(_ lhs: Double, _ rhs: Double, precise value: Int? = nil) -> Bool {
        guard let value = value else {
            return lhs == rhs
        }

        return lhs.precised(value) == rhs.precised(value)
    }
}
