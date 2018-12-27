import UIKit

extension UIViewController {
    func embed(_ child: UIViewController, with insets: UIView.Insets? = nil, respectSafeArea: Bool) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)

        if let insets = insets {
            child.view.constraint(to: view, with: insets, respectSafeArea: respectSafeArea)
        }
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
