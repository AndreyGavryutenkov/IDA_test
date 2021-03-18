import Foundation
import UIKit

/**
 Base view class. Allows to implement fast initialization both int the IB and in the code
 */

class BaseScreenView: UIView {
    
    
    // support of iOS 10 and early versions
    @IBOutlet weak var statusBarHeightConstraint: NSLayoutConstraint?
    
    @IBOutlet weak var bottomKeyboardOffsetConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateStatusBarHeightConstraint()
    }
    
    func onLoad() {

    }
    
    func onAppear() {
        endEditing(true)
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: [.curveEaseIn],
            animations: { [weak self] in
                self?.bottomKeyboardOffsetConstraint?.constant = 0
                self?.setNeedsLayout()
                self?.layoutIfNeeded()
            },
            completion: nil
        )
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func onDisappear() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func onViewTapped() {
        endEditing(true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateStatusBarHeightConstraint()
    }
    
    func updateStatusBarHeightConstraint() {
        
        if #available(iOS 11.0, *) {
            return
        }
        
        guard let statusBarHeightConstraint = statusBarHeightConstraint else { return }
        
        let newHeight: CGFloat
        
        if UIApplication.shared.isStatusBarHidden {
            newHeight = 0.0
        } else {
            newHeight = UIApplication.shared.statusBarFrame.size.height
        }
        
        if statusBarHeightConstraint.constant != newHeight {
            statusBarHeightConstraint.constant = newHeight
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
}


//mark: - Keyboard

extension BaseScreenView {
    
    @objc func keyboardNotification(notification: NSNotification) {
        guard let _ = bottomKeyboardOffsetConstraint else { return }
        
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if let window = UIApplication.shared.delegate?.window! {
                if endFrame!.origin.y < window.frame.maxY {
                    
                    let diff = endFrame!.height
                    setNeedsLayout()
                    layoutIfNeeded()
                    UIView.animate(
                        withDuration: duration,
                        delay: 0,
                        options: animationCurve,
                        animations: { [weak self] in
                            var additionalPadding: CGFloat = 0
                            if #available(iOS 11.0, *) {
                                additionalPadding = self?.safeAreaInsets.bottom ?? 0
                            }
                            self?.bottomKeyboardOffsetConstraint?.constant = diff - additionalPadding
                            self?.setNeedsLayout()
                            self?.layoutIfNeeded()
                        },
                        completion: nil)
                } else {
                    setNeedsLayout()
                    layoutIfNeeded()
                    UIView.animate(
                        withDuration: duration,
                        delay: 0,
                        options: animationCurve,
                        animations: { [weak self] in
                            self?.bottomKeyboardOffsetConstraint?.constant = 0.0
                            self?.setNeedsLayout()
                            self?.layoutIfNeeded()
                        },
                        completion: nil
                    )
                }
            }
        }
    }
}

extension UIView {
    
    @objc func showLoading(progress: Double) {
        
        let loadingView = (subviews.first(where: { $0 is LoaderView }) as? LoaderView) ?? LoaderView()
        
        if loadingView.superview == nil {
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(loadingView)
            
            loadingView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            loadingView.alpha = 0
            
            UIView.animate(
                withDuration: 0.3,
                delay: 0.0,
                options: .transitionCrossDissolve,
                animations: {
                    loadingView.alpha = 1.0
            },
                completion: nil
            )
        }
        
        loadingView.setProgress(progress)
    }
    
    @objc func showLoading() {
        let loaderView = LoaderView()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(loaderView)
        
        loaderView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        loaderView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        loaderView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        loaderView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        loaderView.alpha = 0
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            options: .transitionCrossDissolve,
            animations: {
                loaderView.alpha = 1.0
        },
            completion: nil
        )
    }
    
    @objc func hideLoading() {
        DispatchQueue.main.async {
            for subview in self.subviews {
                if let loader = subview as? LoaderView {
                    UIView.animate(
                        withDuration: 0.3,
                        delay: 0.0,
                        options: .transitionCrossDissolve,
                        animations: {
                            loader.alpha = 0.0
                    },
                        completion: { result in
                            loader.removeFromSuperview()
                    })
                }
            }
        }
    }
}
