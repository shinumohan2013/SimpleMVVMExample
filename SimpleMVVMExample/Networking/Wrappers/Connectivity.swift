//
//  Connectivity.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 26/08/21.
//

import Foundation
import Alamofire

/// Class for check Connectivity
final public class Connectivity {
    
    /// Check network reachable
    static public var isReachable: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
