//
//  UserView.swift
//  Shoppy
//
//  Created by Victor Lourme on 06/07/2020.
//  Copyright © 2020 Victor Lourme. All rights reserved.
//

import SwiftUI
import struct SwiftyShoppy.Settings
import KingfisherSwiftUI

struct UserView: View {
    @State public var network: NetworkObserver
    
    var profileImage: some View {
        Group {
            if network.settings?.settings?.userAvatarURL != nil {
                KFImage(URL(string: (network.settings?.settings?.userAvatarURL)!)!)
                    .resizable()
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
            }
        }
        .frame(width: 65, height: 65)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    profileImage
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text(network.settings?.user?.username ?? "Username")
                            .font(.largeTitle)
                            .bold()
                        
                        Text(network.settings?.user?.email ?? "email@domain.tld")
                            .font(.headline)
                    }
                    .lineLimit(0)
                    
                    Spacer()
                }
                .padding()
                
                Section(header: Text("Account")) {
                    Label(label: "Currency",
                          value: self.network.settings?.settings?.currency ?? "USD",
                          icon: "dollarsign.circle.fill")
                }
                
                Section(header: Text("Payments")) {
                    Label(label: "BTC Address",
                          value: self.network.settings?.settings?.bitcoinAddress ?? "N/A",
                          icon: "b.circle.fill",
                          color: .orange)
                    
                    Label(label: "LTC Address",
                          value: self.network.settings?.settings?.litecoinAddress ?? "N/A",
                          icon: "l.circle.fill",
                          color: .orange)
                    
                    Label(label: "ETH Address",
                          value: self.network.settings?.settings?.ethereumAddress ?? "N/A",
                          icon: "e.circle.fill",
                          color: .orange)
                    
                    Label(label: "PayPal",
                          value: self.network.settings?.settings?.paypalAddress ?? "N/A",
                          icon: "p.circle.fill",
                          color: .orange)
                    
                    Label(label: "Stripe ID",
                          value: self.network.settings?.settings?.stripeAccountId ?? "N/A",
                          icon: "s.circle.fill",
                          color: .orange)
                }
                
                Section(header: Text("Customers"),
                        footer: Text("Your profile can be changed on the website.")) {
                    NavigationLink(destination: FeedbackView(network: self.network)) {
                        Label(label: "See feedbacks", icon: "hand.thumbsup.fill", color: .green)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: SettingsView(network: self.network)) {
                Image(systemName: "gear")
                    .imageScale(.large)
            })
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(network: NetworkObserver(key: ""))
    }
}
