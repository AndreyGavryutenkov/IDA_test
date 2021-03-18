import Foundation
import UIKit

/**
 BaseViewInput. Base view input protocol with default implementations of base methods.
 
 All view input protocols for different screens should be inherited from this protocol
 */
protocol BaseViewInput: class {
    
    func show(error: String)
    func show(error: Error)
    func show(message: String)
    func show(error: Error, completion: @escaping () -> Void)
    func show(error: String, completion: @escaping () -> Void)
    func show(title: String?, message: String?, buttonTitle: String, action: @escaping () -> Void)
    func showLoading()
    func showLoading(progress: Double)
    func hideLoading()
    func viewController() -> UIViewController
    func dismiss(_ animated: Bool, _ completion: (()->())?)
    
}

extension BaseViewInput {
    func dismiss(_ animated: Bool = true, _ completion: (()->())? = nil){
        viewController().dismiss(animated: animated) {
            if let complete = completion {
                complete()
            }
        }
    }
    
}

extension BaseViewInput where Self: UIViewController {
    func show(error: Error) {
        showError(message: error.localizedDescription, viewController: self)
    }
    
    func show(error: String) {
        showError(message: error, viewController: self)
    }
    
    func show(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok".localized, style: .default))
        
        self.present(alert, animated: true)
    }
    
    func show(error: Error, completion: @escaping () -> Void) {
        showError(message: error.localizedDescription, viewController: self, completion: completion)
    }
    
    func show(error: String, completion: @escaping () -> Void) {
        showError(message: error, viewController: self, completion: completion)
    }
    
    func show(title: String?, message: String?, buttonTitle: String, action: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .default))
        alert.addAction(UIAlertAction(title: buttonTitle.localized, style: .default) { _ in
            action()
        })
        
        present(alert, animated: true)
    }
    
    func showLoading() {
        view.showLoading()
    }
    
    func showLoading(progress: Double) {
        view.showLoading(progress: progress)
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.view.hideLoading()
        }
        
    }
    
    func viewController() -> UIViewController {
        //self.modalPresentationStyle = .overFullScreen
        return self
    }
    
//    func dismiss() {
//        viewController().dismiss(animated: true)
//    }
}
