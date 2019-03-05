//
//  ViewController.swift
//  Navigation
//
//  Created by maksim.levakov on 3/5/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet var image: UIImageView!
    private var spinner: Spinner!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        spinner = Spinner(for: image)
        spinner.period = 10.0
    }

    override func viewWillAppear(_ animated: Bool) {
        if animated {
            spinner.run()
        }
    }

    @IBAction func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            changeRotationDirection()
        }
    }

    private func changeRotationDirection() {
        spinner.direction = spinner.direction.inverted()
    }
}

enum Direction: Int {
    case clockwise = 1
    case counterclockwise = -1
}

extension Direction {
    func inverted() -> Direction {
        return Direction(rawValue: -rawValue)!
    }
}

class Spinner {
    var period: Double = 1 {
        didSet {
            if period != oldValue {
                restartAnimation()
            }
        }
    }

    var direction = Direction.clockwise {
        didSet {
            if direction != oldValue {
                restartAnimation()
            }
        }
    }

    private static let animationKey = "spinner.rotation"
    private static let transformationKey = "transform.rotation"

    private let rotatingView: UIView
    private var animationRunning: Bool {
        return rotatingView.layer.animation(forKey: Spinner.animationKey) != nil
    }

    init(for view: UIView) {
        rotatingView = view
    }

    func run() {
        stop()
        startAnimation(fromValue: 0)
    }

    func stop() {
        if animationRunning {
            stopAnimation()
        }
    }

    private func startAnimation(fromValue: Double) {
        rotatingView.layer.add(createAnimation(fromValue: fromValue), forKey: Spinner.animationKey)
    }

    private func stopAnimation() {
        rotatingView.layer.removeAnimation(forKey: Spinner.animationKey)
    }

    private func restartAnimation() {
        if !animationRunning {
            return
        }

        guard let currentRotationValue = rotatingView.layer.presentation()?.value(forKeyPath: Spinner.transformationKey) as? Double else {
            return
        }

        stopAnimation()
        startAnimation(fromValue: currentRotationValue)
    }

    private func createAnimation(fromValue: Double) -> CAAnimation {
        let rotation = CABasicAnimation(keyPath: Spinner.transformationKey)
        rotation.fromValue = fromValue
        rotation.toValue = fromValue + Double(direction.rawValue) * Double.pi * 2
        rotation.duration = period
        rotation.repeatCount = .infinity
        return rotation
    }
}
