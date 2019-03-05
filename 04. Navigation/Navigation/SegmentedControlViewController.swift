//
//  ViewController.swift
//  Navigation
//
//  Created by maksim.levakov on 3/5/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit

class SegmentedControlViewController: UIViewController {
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var backgroundView: UIView!

    private var currentColor: Color {
        return segmentedControl.selectedColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.selectedColor = Color.white
        updateViewColor()
    }

    @IBAction func segmentedControlIndexChanged() {
        updateViewColor()
    }

    private func updateViewColor() {
        backgroundView.backgroundColor = currentColor.uiColor
    }
}

private enum Color {
    case black
    case white
}

private extension UISegmentedControl {
    var selectedColor: Color {
        get {
            return selectedSegmentIndex == 0 ? .black : .white
        }

        set(newColor) {
            selectedSegmentIndex = newColor == .black ? 0 : 1
        }
    }
}

private extension Color {
    var uiColor: UIColor {
        return self == .black ? UIColor.black : UIColor.white
    }
}
