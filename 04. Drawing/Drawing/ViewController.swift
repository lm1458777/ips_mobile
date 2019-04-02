//
//  ViewController.swift
//  Drawing
//
//  Created by maksim.levakov on 3/11/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var canvasView: UICanvas!

    @IBOutlet var pointSizeSlider: UISlider!
    @IBOutlet var pointSizeLabel: UILabel!

    @IBOutlet var redSlider: UISlider!
    @IBOutlet var redValue: UILabel!

    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var greenValue: UILabel!

    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var blueValue: UILabel!

    private var output: ViewOutput? {
        didSet {
            canvasView.output = output
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let painter = PointPainter(view: self)
        painter.diameter = 20
        output = painter
    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        canvasView.setNeedsDisplay()
    }

    @IBAction func clearCanvas() {
        output?.onClear()
    }

    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let pt = sender.location(in: canvasView)
            output?.onTap(Point(x: Double(pt.x), y: Double(pt.y)))
        }
    }

    @IBAction func pointSizeChanged() {
        output?.pointSizeDidChange(diameter: Double(Int(pointSizeSlider.value)))
    }

    @IBAction func colorChanged() {
        guard let color = UIColor(
            red: Int(redSlider.value),
            green: Int(greenSlider.value),
            blue: Int(blueSlider.value)).argb() else {
            return
        }

        output?.pointColorDidChange(color: color)
    }
}

extension ViewController: ViewInput {
    func setPointSize(diameter: Double) {
        pointSizeSlider.value = Float(diameter)
        pointSizeLabel.text = String(Int(diameter))
    }

    func setPointColor(color: Color) {
        guard let (r, g, b, _) = UIColor(rgb: color).rgbaValues() else {
            return
        }

        redValue.text = String(r)
        redSlider.value = Float(r)

        greenSlider.value = Float(g)
        greenValue.text = String(g)

        blueSlider.value = Float(b)
        blueValue.text = String(b)
    }

    func invalidate() {
        canvasView.setNeedsDisplay()
    }
}
