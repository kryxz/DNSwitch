//
//  DNSServerView.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/06.
//


import SwiftUI

struct DNSServerView: View {
    var server: DNSServer

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(server.name ?? "Unnamed Server")
                    .font(.headline)
                Text(server.protocolTypeDescription)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 4)
    }
}
