import UIKit

protocol ProgressDisplayable {
    func startProgress()
    func stopProgress()
}

extension ProgressDisplayable where Self: UIView {
    func startProgress() {
        let whiteValue: CGFloat = 0.7
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor(white: whiteValue, alpha: 1.0)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.tag = 911
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activityIndicator.constraintToCenter(of: self)
    }

    func stopProgress() {
        self.subviews
            .filter { $0.tag == 911 && $0 is UIActivityIndicatorView }
            .forEach { $0.removeFromSuperview() }
    }
}
