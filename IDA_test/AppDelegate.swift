//
//  AppDelegate.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//

import UIKit


var appController: ApplicationProtocol?


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let wnd = UIWindow(frame: UIScreen.main.bounds)

        let flowController : FlowProtocol = FlowController(with: wnd)
        
        appController = AppController(with: flowController)
        appController?.run()
        return true
    }
}

