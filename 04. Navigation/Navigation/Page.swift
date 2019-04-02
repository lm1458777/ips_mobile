//
//  Page.swift
//  Navigation
//
//  Created by maksim.levakov on 3/10/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit

typealias PageColorChangeRequestHandler = (Page) -> Void

protocol Page {
    func doOnPageColorChangeRequest(handler: PageColorChangeRequestHandler?)
    func setTitle(_ text: String)
    var color: UIColor { get }
    func setColor(_ color: UIColor)
}
