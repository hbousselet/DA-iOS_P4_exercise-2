//
//  CustomNavigation.swift
//  UserList
//
//  Created by Hugues Bousselet on 25/10/2024.
//

import SwiftUI

struct CustomNavigation: ViewModifier {
    @ObservedObject var model: UserViewModel
    
    func body(content: Content) -> some View {
        content
        .navigationTitle("Users")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker(selection: $model.isGridView, label: Text("Display")) {
                    Image(systemName: "rectangle.grid.1x2.fill")
                        .tag(true)
                        .accessibilityLabel(Text("Grid view"))
                    Image(systemName: "list.bullet")
                        .tag(false)
                        .accessibilityLabel(Text("List view"))
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Task {
                        await model.reloadUsers()
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.large)
                }
            }
        }
    }
}

extension View {
    func applyNavigation(model: UserViewModel) -> some View {
        modifier(CustomNavigation(model: model))
    }
}
