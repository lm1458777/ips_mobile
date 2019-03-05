//
//  PointShape.swift
//  Drawing
//
//  Created by maksim.levakov on 3/11/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

class PointShape {
    private var center: Point
    private var diameter: Double
    private var color: Color

    init(center: Point, diameter: Double, color: Color) {
        self.center = center
        self.diameter = diameter
        self.color = color
    }
}

extension PointShape: Drawable {
    func draw(canvas: Canvas) {
        canvas.drawCircle(center: center, diameter: diameter, color: color)
    }
}
