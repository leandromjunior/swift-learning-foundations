//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Leandro Motta Junior on 26/08/25.
//

import SwiftUI

struct AdressView: View {
    @Bindable var order: Order
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $order.name)
                    TextField("Street Address", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("Zip", text: $order.zip)
                }
                
                Section {
                    NavigationLink("Check out") {
                        CheckoutView(order: order)
                    }
                }
                .disabled(order.hasValidAddress == false)
            }
            .navigationTitle("Delivery Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AdressView(order: Order())
}
