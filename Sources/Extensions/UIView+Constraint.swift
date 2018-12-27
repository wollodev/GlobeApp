import UIKit

extension UIView {
    public func constraint(to other: UIView, with inset: UIEdgeInsets = .zero) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor, constant: inset.left).isActive = true
        other.trailingAnchor.constraint(equalTo: trailingAnchor, constant: inset.right).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor, constant: inset.top).isActive = true
        other.bottomAnchor.constraint(equalTo: bottomAnchor, constant: inset.bottom).isActive = true
    }
}
