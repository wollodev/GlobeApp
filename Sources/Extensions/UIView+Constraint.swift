import UIKit

extension UIView {
    struct Insets {
        let top: CGFloat?
        let left: CGFloat?
        let bottom: CGFloat?
        let right: CGFloat?

        init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
            self.top = top
            self.left = left
            self.bottom = bottom
            self.right = right
        }
        static let zero: Insets = Insets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func constraint(to other: UIView, with insets: Insets = Insets.zero, respectSafeArea: Bool = false) {

        if let leftConstant = insets.left {
            let otherLeadingAnchor = respectSafeArea ? other.safeAreaLayoutGuide.leadingAnchor : other.leadingAnchor
            leadingAnchor.constraint(equalTo: otherLeadingAnchor, constant: leftConstant).isActive = true
        }

        if let rightConstant = insets.right {
            let otherTrailingAnchor = respectSafeArea ? other.safeAreaLayoutGuide.trailingAnchor : other.trailingAnchor
            otherTrailingAnchor.constraint(equalTo: trailingAnchor, constant: rightConstant).isActive = true
        }

        if let topConstant = insets.top {
            let otherTopAnchor = respectSafeArea ? other.safeAreaLayoutGuide.topAnchor : other.topAnchor
            topAnchor.constraint(equalTo: otherTopAnchor, constant: topConstant).isActive = true
        }

        if let bottomConstant = insets.bottom {
            let otherBottomAnchor = respectSafeArea ? other.safeAreaLayoutGuide.bottomAnchor : other.bottomAnchor
            otherBottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant).isActive = true
        }
    }

    func constraintToCenter(of other: UIView) {
        centerXAnchor.constraint(equalTo: other.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: other.centerYAnchor).isActive = true
    }
}
