//
//  Notification+Extension.swift
//  EquationSolver
//
//  Created by maksim.levakov on 3/4/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit

extension Notification {
    func keyboardHeight() -> CGFloat? {
        if let userInfo = self.userInfo {
            if let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                return keyboardFrame.height
            }
        }

        return nil
    }
}
