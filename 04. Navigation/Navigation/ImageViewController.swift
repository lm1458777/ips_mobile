//
//  ViewController.swift
//  Navigation
//
//  Created by maksim.levakov on 3/5/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    @IBOutlet private var image: UIImageView!
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

    @IBAction private func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            changeRotationDirection()
        }
    }

    private func changeRotationDirection() {
        spinner.direction = spinner.direction.inverted()
    }
}
