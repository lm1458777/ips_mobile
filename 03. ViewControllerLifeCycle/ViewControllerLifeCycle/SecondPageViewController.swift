import UIKit

class SecondPageViewController: UIViewController {
    typealias PageWillDeinit = ([String]) -> Void

    var pageWillDeinit: PageWillDeinit?

    private var log = [String]()

    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("* viewDidLoad")
    }

    override func viewWillAppear(_ animated: Bool) {
        print("** viewWillAppear")
    }

    override func viewWillLayoutSubviews() {
        print("*** viewWillLayoutSubviews")
    }

    override func viewDidLayoutSubviews() {
        print("*** viewDidLayoutSubviews")
    }

    override func viewDidAppear(_ animated: Bool) {
        print("*** viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("** viewWillDisappear")
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("viewWillTransition")
    }

    deinit {
        print("* deinit")
        pageWillDeinit?(log)
    }

    private func print(_ s: String) {
        log.append(s)
    }
}
