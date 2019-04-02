//
//  UICanvas.swift
//  Drawing
//
//  Created by maksim.levakov on 3/12/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit.UIBezierPath

class UICanvas: UIView {
    var output: ViewOutput?

    override func draw(_ rect: CGRect) {
        output?.onDraw(self)
    }
}

extension UICanvas: Canvas {
    func drawCircle(center: Point, diameter: Double, color: Color) {
        let radius = diameter / 2
        let path = UIBezierPath(ovalIn:
            CGRect(
                x: center.x - radius,
                y: center.y - radius,
                width: diameter,
                height: diameter))
        UIColor(rgb: color).setFill()
        path.fill()
    }
}
