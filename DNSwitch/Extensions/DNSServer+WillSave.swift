//
//  DNSServer+WillSave.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/08.
//

import Foundation
import CoreData

extension DNSServer {
    
    override public func willSave() {
        super.willSave()
        
        // ensure no other server remains marked as default.
        if isDefault {
            if let context = self.managedObjectContext {
                let fetchRequest: NSFetchRequest<DNSServer> = DNSServer.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "isDefault == YES AND self != %@", self)
                do {
                    let otherDefaults = try context.fetch(fetchRequest)
                    for server in otherDefaults {
                        server.isDefault = false
                    }
                } catch {
                    print("Failed to fetch default servers: \(error)")
                }
            }
        }
    }
}
