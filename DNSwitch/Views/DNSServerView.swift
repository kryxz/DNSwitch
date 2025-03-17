//
//  DNSServerView.swift
//  DNSwitch
//
//  Created by kryx on 2025/03/06.
//


import SwiftUI

struct DNSServerView: View {
    @ObservedObject var server: DNSServer

    var body: some View {
        HStack {
            if server.isDefault {
                Circle()
                    .fill(Color.green)
                    .frame(width: 10, height: 10)
                    .padding(.trailing, 8)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(server.name!)
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
