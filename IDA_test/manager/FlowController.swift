//
//  FlowController.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//



import Foundation
import UIKit



enum ItinializerType {
    case main
    case detail
    
    func initializer() -> BaseInitializer.Type {
        switch self {
        case .main: return MainScreenInitializer.self
        case .detail: return DetailScreenInitializer.self
        }
    }
}

protocol FlowProtocol {
    var rootViewController: BaseViewController? { get }
    
    func startFlowWith(initializer type: ItinializerType, args: Args?)
    
    func dismiss(vc: BaseViewController, animated: Bool, _ complete: @escaping @convention (swift) ()->())
    func dismissToRoot(animated: Bool)
}


extension FlowProtocol {
    func goHome(animated: Bool = false) {
        goHome(animated: animated)
    }
    
    func dismissToRoot(animated: Bool = false){
        dismissToRoot(animated: animated)
    }
}

struct Flow {
    var keyController: [BaseViewController]
}



class FlowController {
    
    var viewInput: BaseViewInput?
    
    
    var rootViewController: BaseViewController?
    
    var controllersStack: [BaseViewController] = [] {
        didSet {
            rootViewController = controllersStack.last
        }
    }
    
    private let window: UIWindow
    
    init(with window: UIWindow) {
        self.window = window
    }
    
}





extension FlowController: FlowProtocol {
    


    
    
    func dismissToRoot(animated: Bool = false) {
        for topController in controllersStack.reversed() {
            if controllersStack.count > 1 {
                self.dismiss(vc: topController, animated: animated) {
                }
            }
        }
    }
    
    
    func dismiss(vc: BaseViewController, animated: Bool, _ complete: @escaping () -> ()) {
        let _ = self.controllersStack.popLast()
        
        vc.dismiss(animated: animated) {
            complete()
        }
    }
    
    

    

    func startFlowWith(initializer type: ItinializerType, args: Args?) {
        var animated = true
        
        if let args = args {
            if let anim = args[.animated] as? Bool {
                animated = anim
            }
        }
        
        if let vc = type.initializer().initialize(args: args) {
            if self.rootViewController == nil {
                self.rootViewController = vc
                self.window.rootViewController = vc
                self.window.makeKeyAndVisible()
                
            } else {
                self.rootViewController?.present(vc, animated: animated , completion: {
                })
            }
            
            self.controllersStack.append(vc)
        }

    }
    

}
