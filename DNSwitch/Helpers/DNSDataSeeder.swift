//
//  DNSDataSeeder.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/05.
//
import Foundation
import CoreData

func createSampleDNSServers(in context: NSManagedObjectContext) {
    // Google DNS configuration using DNS-over-HTTPS (DoH)
    let googleDNS = DNSServer(
        context: context,
        name: "Google",
        ipv4: ["8.8.8.8", "8.8.4.4"],
        ipv6: ["2001:4860:4860::8888", "2001:4860:4860::8844"],
        serverURL: URL(string: "https://dns.google/dns-query"),
        port: 443,
        protocolType: .doh
    )
    
    // Cloudflare DNS configuration using DNS-over-HTTPS (DoH)
    let cloudflareDNS = DNSServer(
        context: context,
        name: "Cloudflare",
        ipv4: ["1.1.1.1", "1.0.0.1"],
        ipv6: ["2606:4700:4700::1111", "2606:4700:4700::1001"],
        serverURL: URL(string: "https://cloudflare-dns.com/dns-query"),
        port: 443,
        protocolType: .doh
    )
    
    _ = DNSServer(
        context: context,
        name: "AdGuard",
        ipv4: ["94.140.14.14", "94.140.15.15"],
        ipv6: ["2a10:50c0::ad1:ff", "2a10:50c0::ad2:ff"],
        // Using a custom URL scheme for DoT. Adjust or set to nil if not needed.
        serverURL: URL(string: "tls://dns.adguard.com"),
        port: 853,
        protocolType: .dot
    )
        
    
    _ = DNSServer(
        context: context,
        name: "AdGuard",
        ipv4: ["94.140.14.14", "94.140.15.15"],
        ipv6: ["2a10:50c0::ad1:ff", "2a10:50c0::ad2:ff"],
        // Using a custom URL scheme for DoT. Adjust or set to nil if not needed.
        serverURL: URL(string: "https://dns.adguard-dns.com/dns-query"),
        port: 443,
        protocolType: .doh
    )
    
    
    let fallback = ServerFallback(context: context)
    fallback.order = 0
    fallback.primary = cloudflareDNS
    fallback.fallback = googleDNS
    cloudflareDNS.addToServerFallbacks(fallback)
    
    
    
    do {
        try context.save()
        print("Sample DNS servers created and saved successfully.")
    } catch {
        print("Error saving sample DNS servers: \(error)")
    }
}
