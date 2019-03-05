//
//  Palette.swift
//  Navigation
//
//  Created by maksim.levakov on 3/10/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit

class Palette {
    private static let allColors: Set<UIColor> = [
        UIColor.black,
        UIColor.blue,
        UIColor.brown,
        UIColor.cyan,
        UIColor.darkGray,
        UIColor.gray,
        UIColor.green,
        UIColor.lightGray,
        UIColor.magenta,
        UIColor.orange,
        UIColor.purple,
        UIColor.red,
        UIColor.white,
        UIColor.yellow,
    ]

    private var usedColors = [UIColor: Int]()

    func useColor(_ color: UIColor, numberOfNewUsers: Int = 1) {
        guard numberOfNewUsers > 0 else {
            assert(false, "The numberOfNewUsers must be greater then 0")
            return
        }

        let useCount = usedColors[color] ?? 0
        usedColors.updateValue(useCount + numberOfNewUsers, forKey: color)
    }

    func unuseColor(_ color: UIColor) {
        guard let useCount = usedColors[color], useCount > 0 else {
            assert(false, "The color is not used")
            return
        }

        if useCount == 1 {
            usedColors.removeValue(forKey: color)
        } else {
            usedColors.updateValue(useCount - 1, forKey: color)
        }
    }

    func clearUsedColors() {
        usedColors.removeAll()
    }

    func getRandomColor() -> UIColor? {
        let availableColors = Palette.allColors.subtracting(usedColors.keys)
        return availableColors.randomElement()
    }
}
