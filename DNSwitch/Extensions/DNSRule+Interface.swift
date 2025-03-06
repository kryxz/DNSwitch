//
//  DNSRule+Interface.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/05.
//

import Foundation

extension DNSRule {
    @NSManaged public var interfaceValue: Int16

    public var interface: NetworkInterface {
        get { NetworkInterface(rawValue: interfaceValue) ?? .wifi }
        set { interfaceValue = newValue.rawValue }
    }
}
