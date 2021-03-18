import UIKit

/**
 BaseViewController. Base view controller for modules view controllers
 */

protocol BaseViewProtocol {
    associatedtype ViewClass: UIView
}

extension BaseViewProtocol where Self: BaseViewController  {
    
    var rootView: ViewClass {
        get {
            return view as! ViewClass
        }
    }
}


class BaseTabBarController: UITabBarController{
    var output: BaseViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
                
        if let didLoad = output?.didLoad {
            didLoad()
        }
    }
}

class BaseViewController: UIViewController {
    //typealias OutputClass = BaseViewOutput
    
    
    var output: BaseViewOutput?
    
    let navigationBarOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        view.autoresizingMask = .flexibleWidth
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        
        //automaticallyAdjustsScrollViewInsets = false
        
        if let rootView = view as? BaseScreenView {
            rootView.onLoad()
        }
        
        if let didLoad = output?.didLoad {
            didLoad()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if let navigationBar = navigationController?.navigationBar {
//            updateNavigationBarOverlaySize()
//            navigationBar.insertSubview(navigationBarOverlay, at: 0)
//        }
        
        if let willAppear = output?.willAppear {
            willAppear()
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let rootView = view as? BaseScreenView {
            rootView.onDisappear()
        }
        
        if let willDisappear = output?.willDisappear {
            willDisappear()
        }

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        navigationBarOverlay.removeFromSuperview()
        
        if let didDisappear = output?.didDisappear {
            didDisappear()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let rootView = view as? BaseScreenView {
            rootView.onAppear()
        }
        
        if let didAppear = output?.didAppear {
            didAppear()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        updateNavigationBarOverlaySize()
    }
    

    
    func extract(){
        print("try to extract: \(self.classForCoder)")
    }
}



//mark: - Navigation bar overlay

extension BaseViewController {
    
    func updateNavigationBarOverlaySize() {
//        if let navigationBar = navigationController?.navigationBar {
//            navigationBarOverlay.frame = CGRect(x: 0, y: -UIApplication.shared.statusBarFrame.height, width: navigationBar.bounds.width, height: navigationBar.bounds.height + UIApplication.shared.statusBarFrame.height)
//        }
    }
}

extension BaseViewController {
    
}
