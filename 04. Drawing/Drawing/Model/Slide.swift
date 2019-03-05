//
//  Slide.swift
//  Drawing
//
//  Created by maksim.levakov on 3/11/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

class Slide {
    typealias SlideDidChangeCallback = () -> Void

    var slideDidChange: SlideDidChangeCallback?

    private var shapes: [Drawable] = []

    func addShape(shape: Drawable) {
        shapes.append(shape)
        notify()
    }

    func clear() {
        shapes.removeAll()
        notify()
    }

    func draw(canvas: Canvas) {
        shapes.forEach { $0.draw(canvas: canvas) }
    }

    private func notify() {
        if let callback = slideDidChange {
            callback()
        }
    }
}
