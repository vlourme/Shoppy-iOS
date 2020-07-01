//
//  OrderCard.swift
//  Shoppy
//
//  Created by Victor Lourme on 01/07/2020.
//  Copyright © 2020 Victor Lourme. All rights reserved.
//

import SwiftUI

struct OrderCard: View {
    @State public var email: String
    @State public var description: String
    @State public var price: Double
    @State public var currency: String
    @State public var paid: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(email)
                HStack {
                    if paid == 1 {
                        Image(systemName: "checkmark")
                        Text("Paid — ")
                        + Text(description)
                    } else {
                        Image(systemName: "xmark")
                        Text("Cancelled — ")
                        + Text(description)
                    }
                    
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }.lineLimit(0)
            
            Spacer()
            
            Text("\(price, specifier: "%0.2f")")
                + Text(Currencies.getSymbol(forCurrencyCode: currency) ?? "$")
                    .font(.caption)
            
            Image(systemName: "chevron.right")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .foregroundColor(.black)
        .background(Color.white)
        .cornerRadius(15)
        .padding([.leading, .trailing])
        .shadow(radius: 8)
    }
}

struct OrderCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            OrderCard(email: "averyveryveryverylongmail@example.com",
                      description: "Lorem Ipsum",
                      price: 20,
                      currency: "EUR",
                      paid: 1)
            OrderCard(email: "test@example.com",
                      description: "Lorem Ipsum",
                      price: 9.99,
                      currency: "USD",
                      paid: 0)
            OrderCard(email: "anotherexample@example.com",
                      description: "Lorem Ipsum",
                      price: 195.43,
                      currency: "GBP",
                      paid: 0)
        }
    }
}
