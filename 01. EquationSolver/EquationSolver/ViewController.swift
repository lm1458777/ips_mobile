//
//  ViewController.swift
//  EquationSolver
//
//  Created by maksim.levakov on 2/18/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var header: UINavigationItem!
    @IBOutlet var solveButton: UIBarButtonItem!

    @IBOutlet var coeffA: UITextField!
    @IBOutlet var coeffB: UITextField!
    @IBOutlet var coeffC: UITextField!

    @IBOutlet var singleRoot: UIStackView!
    @IBOutlet var x: UILabel!

    @IBOutlet var roots: UIStackView!
    @IBOutlet var x1: UILabel!
    @IBOutlet var x2: UILabel!

    @IBOutlet var textResult: UILabel!

    private let solver = Solver()

    private lazy var formatter = { () -> NumberFormatter in
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        header.title = ViewController.localized("EQUATION_SOLVER")
        solveButton.title = ViewController.localized("SOLVE")
        navigationController?.setToolbarHidden(false, animated: true)

        initSample()
    }

    @IBAction func solve(_ sender: Any) {
        guard let a = value(coeffA) else {
            invalidValue("A")
            return
        }

        guard let b = value(coeffB) else {
            invalidValue("B")
            return
        }

        guard let c = value(coeffC) else {
            invalidValue("C")
            return
        }

        show(solver.solve(a: a, b: b, c: c))
    }

    private func initSample() {
        let a = 1.0
        coeffA.text = toString(a)

        let b = 5.0
        coeffB.text = toString(b)

        let c = 6.0
        coeffC.text = toString(c)

        show(solver.solve(a: a, b: b, c: c))
    }

    private func invalidValue(_ name: String) {
        var msg = ViewController.localized("NUMBER_IS_NEEDED")
        msg.append(" '")
        msg.append(name)
        msg.append("'")

        view.makeToast(msg)
    }

    private func show(_ r: Roots) {
        switch r {
        case .noRealRoots:
            showResult("NO_REAL_ROOTS")
        case .infiniteNumberOfRoots:
            showResult("INFINITE_NUMBER_OF_ROOTS")
        case let .root(x):
            showRoot(x)
        case let .roots(x1, x2):
            showRoots(x1, x2)
        }
    }

    private func showRoots(_ x1: Double, _ x2: Double) {
        textResult.isHidden = true
        singleRoot.isHidden = true
        roots.isHidden = false

        self.x1.text = toString(x1)
        self.x2.text = toString(x2)
    }

    private func showRoot(_ x: Double) {
        textResult.isHidden = true
        singleRoot.isHidden = false
        roots.isHidden = true

        self.x.text = toString(x)
    }

    private func showResult(_ msg: String) {
        textResult.isHidden = false
        singleRoot.isHidden = true
        roots.isHidden = true

        textResult.text = ViewController.localized(msg)
    }

    private static func localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

    private func toString(_ d: Double) -> String {
        return formatter.string(from: NSNumber(value: d)) ?? ""
    }

    private func value(_ field: UITextField) -> Double? {
        if let t = field.text?.trimmingCharacters(in: .whitespaces) {
            let n = formatter.number(from: t)
            return n?.doubleValue
        }

        return nil
    }
}
