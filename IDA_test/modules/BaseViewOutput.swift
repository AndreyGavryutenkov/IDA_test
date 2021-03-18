import Foundation

/**
 BaseViewOutput. Base view output protocol. All view output protocols for different screens should be inherited
 from this protocol.
 */
@objc protocol BaseViewOutput {
    @objc optional func didLoad()
    @objc optional func willAppear()
    @objc optional func didAppear()
    @objc optional func willDisappear()
    @objc optional func didDisappear()
}

protocol BaseViewControllerOutputProtocol {
    associatedtype OutputClass
}

extension BaseViewControllerOutputProtocol where Self: BaseViewController  {
    
    var viewOutput: OutputClass? {
        get {
            return output as? OutputClass
        }
    }
    
}
