//
//  DNSServer+DNSProtocol.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/05.
//

import Foundation

extension DNSServer {
    var protocolTypeEnum: DNSProtocol {
        get {
            DNSProtocol(rawValue: self.protocolType) ?? .doh
        }
        set {
            self.protocolType = newValue.rawValue
        }
    }
    
    var protocolTypeDescription: String {
        return protocolTypeEnum.description
    }
}
