//
//  PagesViewController.swift
//  Navigation
//
//  Created by maksim.levakov on 3/9/19.
//  Copyright © 2019 maksim.levakov. All rights reserved.
//

import UIKit

class PagesViewController: UIPageViewController {
    private let palette = { () -> Palette in
        let palette = Palette()
        PagesViewController.excludeColors(from: palette)
        return palette
    }()

    private lazy var pages: [UIViewController] = {
        let defaultColor = UIColor.white
        palette.useColor(defaultColor, numberOfNewUsers: 4)
        return [
            createPage(title: "Page 1", color: defaultColor),
            createPage(title: "Page 2", color: defaultColor),
            createPage(title: "Page 3", color: defaultColor),
            createPage(title: "Page 4", color: defaultColor),
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        if let firstVC = pages.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        view.backgroundColor = UIColor.lightGray
    }

    @IBAction func clearColors(_ sender: Any) {
        let color = UIColor.white
        pages.forEach {
            if let page = $0 as? Page {
                page.setColor(color)
            }
        }
        palette.clearUsedColors()
        PagesViewController.excludeColors(from: palette)
        palette.useColor(color, numberOfNewUsers: pages.count)
    }

    func changePageColor(_ sender: Page) {
        guard let newColor = palette.getRandomColor() else {
            return
        }

        let oldColor = sender.color
        sender.setColor(newColor)
        palette.useColor(newColor)
        palette.unuseColor(oldColor)
    }

    private func createPage(title: String, color: UIColor) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page.template")
        if let page = vc as? Page {
            page.setTitle(title)
            page.setColor(color)
            page.doOnPageColorChangeRequest(handler: { [unowned self] page in
                self.changePageColor(page)
            })
        }
        return vc
    }

    private static func excludeColors(from palette: Palette) {
        palette.useColor(UIColor(rgb: 0xCCFFCC)) // button
        palette.useColor(UIColor(rgb: 0xFFFFCC)) // title
    }
}

extension PagesViewController: UIPageViewControllerDataSource {
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
    
            let nextIndex = viewControllerIndex + 1
    
            guard nextIndex < pages.count else { return pages.first }
    
            guard pages.count > nextIndex else { return nil }
    
            return pages[nextIndex]
        }
}

extension PagesViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else { return pages.last }

        guard pages.count > previousIndex else { return nil }

        return pages[previousIndex]
    }
}
