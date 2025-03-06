//
//  DNSwitchEnums.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/05.
//


import Foundation

public enum NetworkInterface: Int16 {
    case wifi = 0
    case cellular = 1
    case vpn = 2
}

public enum DNSProtocol: Int16, CustomStringConvertible {
    case standard = 0
    case doh = 1
    case dot = 2
    
    public var description: String {
        switch self {
        case .standard:
            return "Standard DNS"
        case .doh:
            return "DNS over HTTPS"
        case .dot:
            return "DNS over TLS"
        }
    }
}

