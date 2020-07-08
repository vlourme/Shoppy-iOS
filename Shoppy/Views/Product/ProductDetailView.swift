//
//  ProductDetailView.swift
//  Shoppy
//
//  Created by Victor Lourme on 02/07/2020.
//  Copyright © 2020 Victor Lourme. All rights reserved.
//

import SwiftUI
import SwiftyShoppy
import KeychainSwift

struct ProductDetailView: View {
    @Environment(\.presentationMode) var presentation
    @State public var product: Product
    @State private var isPresented = false
    private let keychain = KeychainSwift()
    
    // Delete product
    private func deleteProduct() {
        // Get product ID
        guard let id = product.id else {
            return
        }
        
        // Get token
        if let key = keychain.get("key") {
            NetworkManager
                .prepare(token: key)
                .target(.deleteProduct(id))
                .asObject(UpdatedProduct.self, success: { update in
                    // Dismiss
                    self.presentation.wrappedValue.dismiss()
                }, error: { error in
                    print(error)
                })
        }
    }
    
    // Open action sheet
    var showAction: some View {
        Button(action: {
            self.isPresented = true
        }) {
            Image(systemName: "square.and.pencil")
                .resizable()
                .frame(width: 26, height: 26)
        }
    }
    
    // Body
    var body: some View {
        ScrollView {
            Container {
                if self.product.description != nil {
                    ContainerNavigationButton(title: "See the description", icon: "text.alignleft", destination: AnyView(ProductDetailledView(name: "Description", value: self.product.description ?? "")))
                }
                ContainerField(name: "Delivery type", value: self.product.type?.rawValue.capitalized ?? "", icon: "cube.box")
            }
            
            Container {
                ContainerField(name: "Price", value: "\(self.product.price ?? 0)", icon: "bag.fill")
                if self.product.type == .account {
                    ContainerField(name: "Revenue per order", value: "\((self.product.price ?? 0) * Double(self.product.quantity?.min ?? 0))", icon: "equal.square")
                    ContainerField(name: "Potential total", value: "\((self.product.price ?? 0) * Double(self.product.stock?.get() ?? 0))", icon: "equal.square.fill")
                }
                ContainerField(name: "Currency", value: self.product.currency ?? "", icon: "dollarsign.circle.fill")
            }
            
            if self.product.type == .account || self.product.type == .dynamic {
                Container {
                    if self.product.type == .account {
                        ContainerField(name: "Stock", value: "\(self.product.stock?.get() ?? 0)", icon: "cart.fill")
                    }
                    
                    ContainerField(name: "Minimum quantity per order", value: "\(self.product.quantity?.min ?? 0)", icon: "minus.circle.fill")
                    ContainerField(name: "Maximum quantity per order", value: "\(self.product.quantity?.max ?? 0)", icon: "plus.circle.fill")
                }
            }
            
            Container {
                ContainerField(name: "Unlisted", value: self.product.unlisted ?? false ? "Yes" : "No", icon: "eye.slash")
                ContainerField(name: "Product ID", value: self.product.id ?? "", icon: "number")
                ContainerField(name: "Creation date", value: self.product.created_at?.description ?? "", icon: "calendar")
                ContainerField(name: "Last update", value: self.product.updated_at?.description ?? "", icon: "clock.fill")
            }
            
            Spacer()
        }
        .navigationBarTitle(product.title ?? "Product")
        .navigationBarItems(trailing: showAction)
        .actionSheet(isPresented: $isPresented) {
            ActionSheet(title: Text("Select an action"), buttons: [
                .destructive(Text("Delete product"), action: self.deleteProduct),
                .cancel()
            ])
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product())
    }
}
