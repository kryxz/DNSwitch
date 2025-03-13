//
//  DNSServerDetailView.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/08.
//


import SwiftUI
import CoreData

struct DNSServerDetailView: View {
    @ObservedObject var server: DNSServer

    var body: some View {
        Form {
            Toggle("Use Server", isOn: $server.isDefault)
                .onChange(of: server.isDefault) { oldValue, newValue in
                    setDefaultServer()
                }
        }
        .navigationTitle(server.name!)
    }
    
    private func setDefaultServer() {
        do {
            try server.managedObjectContext?.save()
        } catch {
            print("Error saving default server: \(error)")
        }
        
        DNSManagementService.shared.configureDefaultDNS(with: server) { error in
            if let error = error {
                print("Error configuring default DNS: \(error)")
            } else {
                print("Default DNS configuration updated.")
            }
        }
    }
    
}

struct DNSServerDetailView_Previews: PreviewProvider {
    static var previews: some View {

        let viewContext = PersistenceController.preview.container.viewContext
        let server = DNSServer(
            context: viewContext,
            name: "Cloudflare",
            ipv4: ["1.1.1.1", "1.0.0.1"],
            ipv6: ["2606:4700:4700::1111", "2606:4700:4700::1001"],
            serverURL: URL(string: "https://cloudflare-dns.com/dns-query"),
            port: 443,
            protocolType: .doh
        )
        
        return NavigationView {
            DNSServerDetailView(server: server)
                .environment(\.managedObjectContext, viewContext)
        }
    }
}
