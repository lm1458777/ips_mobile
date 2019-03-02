//
//  Solver.swift
//  EquationSolver
//
//  Created by maksim.levakov on 2/25/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import Foundation

// typedef boost::variant<NoRealRoots, InfiniteNumberOfRoots, double, std::pair<double, double>> EquationRoots;

enum Roots {
    case noRealRoots
    case infiniteNumberOfRoots
    case root(x: Double)
    case roots(x1: Double, x2: Double)
}

class Solver {
    func solve(a: Double, b: Double, c: Double) -> Roots {
        let P = 5
        let Zero = Double(0).precised(P)

        if abs(a) > 0 {
            let d = b * b - 4 * a * c

            if d < 0 {
                return Roots.noRealRoots
            }

            let _sqrtD = sqrt(d)
            let _2a = 2 * a

            if d.precised(P) == Zero {
                return Roots.root(x: (-b + _sqrtD) / _2a)
            }

            return Roots.roots(
                x1: (-b - _sqrtD) / _2a,
                x2: (-b + _sqrtD) / _2a)
        }

        // b * x + c = 0
        if abs(b).precised(P) > Zero {
            return Roots.root(x: -c / b)
        }

        if abs(c).precised(P) > Zero { // 0 * x + c = 0
            return Roots.noRealRoots
        }

        return Roots.infiniteNumberOfRoots // 0 * x = 0
    }
}
