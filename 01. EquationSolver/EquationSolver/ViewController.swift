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
    @IBOutlet var solveButton: UIButton!

    @IBOutlet var coeffA: UITextField!
    @IBOutlet var coeffB: UITextField!
    @IBOutlet var coeffC: UITextField!

    @IBOutlet var singleRoot: UIStackView!
    @IBOutlet var x: UILabel!

    @IBOutlet var roots: UIStackView!
    @IBOutlet var x1: UILabel!
    @IBOutlet var x2: UILabel!

    @IBOutlet var contentView: UIView!
    @IBOutlet var contentBottomConstraint: NSLayoutConstraint!

    @IBOutlet var textResult: UILabel!

    private var activeField: UITextField?

    private let solver = Solver()

    private let formatter = Formatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        coeffA.delegate = self
        coeffB.delegate = self
        coeffC.delegate = self

        registerForKeyboardNotifications()

        view.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(onTap))
        )

        header.title = ViewController.localized("EQUATION_SOLVER")
        solveButton.setTitle(ViewController.localized("SOLVE"), for: UIControl.State.normal)

        initSample()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func onTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            dissmissKeyboard()
        }
    }

    private func dissmissKeyboard() {
        if let f = activeField {
            f.resignFirstResponder()
            activeField = nil
        }
    }

    private func registerForKeyboardNotifications() {
        let notifications = NotificationCenter.default
        notifications.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        notifications.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardDidShow(notification: Notification) {
        guard let kbdHeight = notification.keyboardHeight() else {
            return
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.contentBottomConstraint.constant = -kbdHeight
        })
    }

    @objc private func keyboardWillHide(_: Notification) {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentBottomConstraint.constant = 0
        })
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
        coeffA.text = formatter.toString(a)

        let b = 5.0
        coeffB.text = formatter.toString(b)

        let c = 6.0
        coeffC.text = formatter.toString(c)

        show(solver.solve(a: a, b: b, c: c))
    }

    private func invalidValue(_ name: String) {
        var msg = ViewController.localized("NUMBER_IS_NEEDED")
        msg.append(" '")
        msg.append(name)
        msg.append("'")

        hideResult()

        let frame = contentView.frame
        view.makeToast(
            msg,
            point: CGPoint(x: frame.midX, y: frame.midY),
            title: nil,
            image: nil,
            completion: nil)
    }

    private func show(_ r: Roots) {
        view.hideToast()

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

        self.x1.text = formatter.toString(x1)
        self.x2.text = formatter.toString(x2)
    }

    private func showRoot(_ x: Double) {
        textResult.isHidden = true
        singleRoot.isHidden = false
        roots.isHidden = true

        self.x.text = formatter.toString(x)
    }

    private func showResult(_ msg: String) {
        textResult.isHidden = false
        singleRoot.isHidden = true
        roots.isHidden = true

        textResult.text = ViewController.localized(msg)
    }

    private func hideResult() {
        textResult.isHidden = true
        singleRoot.isHidden = true
        roots.isHidden = true
    }

    private static func localized(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }

    private func value(_ field: UITextField) -> Double? {
        if let t = field.text?.trimmingCharacters(in: .whitespaces), !t.isEmpty {
            return formatter.parseDouble(t)
        }

        return nil
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dissmissKeyboard()
        return true
    }
}
