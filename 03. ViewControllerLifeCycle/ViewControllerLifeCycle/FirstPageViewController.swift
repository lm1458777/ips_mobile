import UIKit

class FirstPageViewController: UIViewController {
    @IBOutlet var descLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let text = """
        Перейти на страницу "Second Page" и вернуться назад.
        Через 2с после возврата в Debug Output будут выведены сообщения, связанные с жизненным циклом ViewController'а.
        """
        let currentAttributes = descLabel.attributedText?.attributes(at: 0, effectiveRange: nil)
        descLabel.attributedText = NSAttributedString(string: text, attributes: currentAttributes)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let secondPage = segue.destination as? SecondPageViewController {
            secondPage.pageWillDeinit = FirstPageViewController.secondPageWillDeinit
        }
    }

    private static func secondPageWillDeinit(log: [String]) {
        DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(2), execute: {
            for s in log {
                print(s)
            }
        })
    }
}
