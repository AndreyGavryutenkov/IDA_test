//
//  NetworkManager.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/21/21.
//
import UIKit
import SystemConfiguration



protocol NetworkAvailabilityDelegate {
    func disconnectFromNetwork()
    func networkIsAvailableAgain ()
}

protocol NetworkAvailabilityInterface {
    var canWork : Bool { get set }
    var isNetworkAvailable: Bool { get set }
    var delegate: NetworkAvailabilityDelegate? { get set }
    
    func ifNetworkNotAvailable (_ action: ()->())
}


class NetworkAvailabilityManager {
    var delegate : NetworkAvailabilityDelegate?
    var canWork: Bool  = true
    var isNetworkAvailable: Bool = true
    let timeToCheck: TimeInterval
    
    
    ///- timeInterval:
    ///
    ///  time in sec to check network is available
    init(with timeIntervalToCheck: TimeInterval) {
        self.timeToCheck = timeIntervalToCheck
        self.listenTheNetwork()
    }
    
    
    @objc private func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        
        
        if  self.isNetworkAvailable != ret {
            switch ret {
            case true:
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.networkIsAvailableAgain()
                }
                
            case false:
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.disconnectFromNetwork()
                }
            }
        }

        self.isNetworkAvailable = ret
        return ret
        
    }
    
    fileprivate func listenTheNetwork (){
        let _ = Timer.scheduledTimer(timeInterval: timeToCheck, target: self, selector: #selector(isConnectedToNetwork), userInfo: nil, repeats: true)
    }
    
    
}///EOC

extension NetworkAvailabilityManager: NetworkAvailabilityInterface {
    func ifNetworkNotAvailable(_ action: () -> ()) {
        if !self.isNetworkAvailable {
            action()
        }
    }
    
    
}










