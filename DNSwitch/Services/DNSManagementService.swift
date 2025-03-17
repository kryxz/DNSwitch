//
//  DNSManagementService.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/08.
//

import Foundation
import NetworkExtension


class DNSManagementService {
    static let shared = DNSManagementService()
    
    private init() {}
    
    /// Configures the system DNS settings using the given DNSServer.
    /// - Parameters:
    ///   - server: The DNSServer instance containing the DNS configuration data.
    ///   - completion: Called with an optional error once the operation completes.
    func configureDefaultDNS(with server: DNSServer, completion: @escaping (Error?) -> Void) {
        let dnsManager = NEDNSSettingsManager.shared()
        
        dnsManager.loadFromPreferences { loadError in
            if let loadError = loadError {
                completion(loadError)
                return
            }
            
            var dnsSettings: NEDNSSettings?
            // Use IPv4 addresses as the server list.
            let ipv4Servers = server.ipv4 as? [String] ?? []
            
            switch server.protocolTypeEnum {
            case .doh:
                // DNS-over-HTTPS configuration
                guard let serverURL = server.serverURL else {
                    let error = NSError(
                        domain: "DNSManagementService",
                        code: 1,
                        userInfo: [NSLocalizedDescriptionKey: "Missing server URL for DoH configuration."]
                    )
                    completion(error)
                    return
                }
                let dohSettings = NEDNSOverHTTPSSettings(servers: ipv4Servers)
                dohSettings.serverURL = serverURL
                dnsSettings = dohSettings
                
            case .dot:
                // DNS-over-TLS configuration
                let dotSettings = NEDNSOverTLSSettings(servers: ipv4Servers)
                // Attempt to extract the hostname from the URL (e.g., "dns.adguard.com")
                if let host = server.serverURL?.host {
                    dotSettings.serverName = host
                } else {
                    dotSettings.serverName = server.name // fallback if URL isn't available
                }
                dnsSettings = dotSettings
                
            default:
                // Fallback: if serverURL is provided, use DoH; otherwise, use DoT.
                if let serverURL = server.serverURL {
                    let dohSettings = NEDNSOverHTTPSSettings(servers: ipv4Servers)
                    dohSettings.serverURL = serverURL
                    dnsSettings = dohSettings
                } else {
                    let dotSettings = NEDNSOverTLSSettings(servers: ipv4Servers)
                    dotSettings.serverName = server.name
                    dnsSettings = dotSettings
                }
            }
            
            // Update the DNS settings manager with the new settings.
            dnsManager.dnsSettings = dnsSettings
            dnsManager.localizedDescription = server.name
            
            dnsManager.saveToPreferences { saveError in
                if let saveError = saveError {
                    print("Error saving DNS configuration: \(saveError)")
                } else {
                    print("Default DNS configuration updated.")
                }
                completion(saveError)
            }
        }
    }
}
