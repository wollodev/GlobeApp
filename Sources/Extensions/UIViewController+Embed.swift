import UIKit

extension UIViewController {
    func embed(_ child: UIViewController, with inset: UIEdgeInsets = .zero) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)

        child.view.constraint(to: view, with: inset)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
