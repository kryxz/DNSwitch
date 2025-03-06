//
//  DNSServer+Convenience.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/05.
//

import Foundation
import CoreData

extension DNSServer {
    /// Convenience initializer to create a DNSServer instance
    convenience init(context: NSManagedObjectContext,
                     name: String,
                     ipv4: [String]? = nil,
                     ipv6: [String]? = nil,
                     serverURL: URL? = nil,
                     port: Int16 = 53,
                     protocolType: DNSProtocol = .standard) {
        let entity = NSEntityDescription.entity(forEntityName: "DNSServer", in: context)!
        self.init(entity: entity, insertInto: context)
        
        self.name = name
        self.ipv4 = ipv4 as NSArray?   // Cast [String]? to NSArray?
        self.ipv6 = ipv6 as NSArray?   // Cast [String]? to NSArray?
        self.serverURL = serverURL
        self.port = port
        self.protocolType = protocolType.rawValue
    }
}

