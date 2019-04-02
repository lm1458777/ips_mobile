//
//  Direction.swift
//  Navigation
//
//  Created by maksim.levakov on 4/2/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

enum Direction: Int {
    case clockwise = 1
    case counterclockwise = -1
}

extension Direction {
    func inverted() -> Direction {
        return Direction(rawValue: -rawValue)!
    }
}
