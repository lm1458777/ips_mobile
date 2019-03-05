//
//  ViewProtocols.swift
//  Drawing
//
//  Created by maksim.levakov on 3/13/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

protocol ViewOutput {
    func onTap(_ point: Point)
    func onDraw(_ canvas: Canvas)
    func onClear()
    func pointSizeDidChange(diameter: Double)
    func pointColorDidChange(color: Color)
}

protocol ViewInput: class {
    func setPointSize(diameter: Double)
    func setPointColor(color: Color)
    func invalidate()
}
