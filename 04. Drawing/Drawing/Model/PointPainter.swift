//
//  PointPainter.swift
//  Drawing
//
//  Created by maksim.levakov on 3/11/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

class PointPainter {
    private let slide = Slide()
    weak var view: ViewInput?

    var diameter: Double = 1 {
        didSet(oldValue) {
            if oldValue != diameter {
                view?.setPointSize(diameter: diameter)
            }
        }
    }

    var color: Color = 0 {
        didSet(oldValue) {
            if oldValue != color {
                view?.setPointColor(color: color)
            }
        }
    }

    init(view: ViewInput) {
        self.view = view
        view.setPointColor(color: color)
        view.setPointSize(diameter: diameter)

        slide.slideDidChange = { [weak view] in view?.invalidate() }
    }

    func drawPoint(center: Point) {
        slide.addShape(shape: PointShape(center: center, diameter: diameter, color: color))
    }
}

extension PointPainter: ViewOutput {
    func pointSizeDidChange(diameter: Double) {
        self.diameter = diameter
    }

    func pointColorDidChange(color: Color) {
        self.color = color
    }

    func onTap(_ point: Point) {
        drawPoint(center: point)
    }

    func onDraw(_ canvas: Canvas) {
        slide.draw(canvas: canvas)
    }

    func onClear() {
        slide.clear()
    }
}
