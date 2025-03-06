//
//  DNSServersListView.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/04.
//

import SwiftUI
import CoreData


struct DNSServersListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: DNSServer.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \DNSServer.name, ascending: true)],
        animation: .default)
    
    private var servers: FetchedResults<DNSServer>

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Servers").font(.headline).padding(.vertical, 4)) {
                    ForEach(servers) { server in
                        NavigationLink {
                            Text("Detail view for \(server.name ?? "Unnamed Server")")
                                .navigationTitle(server.name ?? "Server Details")
                        } label: {
                            DNSServerView(server: server)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("DNSwitch")
            .toolbar {
                ToolbarItem {
                    Button(action: addServer) {
                        Label("Add Server", systemImage: "plus")
                    }
                }
            }
        }
        .onAppear {
            // Seed sample servers if none exist.
            if servers.isEmpty {
                createSampleDNSServers(in: viewContext)
            }
        }
    }

    private func addServer() {
        // Logic to add a new DNSServer goes here.
    }
}

#Preview {
    DNSServersListView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
