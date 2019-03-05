//
//  PageViewController.swift
//  Navigation
//
//  Created by maksim.levakov on 3/10/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
    var output: ChangePageColorCallback?

    @IBOutlet var titleLabel: UILabel!

    private var pageTitle = "" {
        didSet(oldTitle) {
            if oldTitle != pageTitle {
                titleLabel?.text = pageTitle
            }
        }
    }

    private var pageColor = UIColor.white {
        didSet(oldColor) {
            if oldColor != pageColor {
                view?.backgroundColor = pageColor
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = pageTitle
        view.backgroundColor = pageColor
    }

    @IBAction func changeColorButtonPressed() {
        output?(self)
    }
}

extension PageViewController: Page {
    func setOutput(output: ChangePageColorCallback?) {
        self.output = output
    }

    var color: UIColor { return pageColor }

    func setColor(_ color: UIColor) {
        pageColor = color
    }

    func setTitle(_ text: String) {
        pageTitle = text
    }
}
