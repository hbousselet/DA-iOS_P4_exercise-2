//
//  CustomNavigation.swift
//  UserList
//
//  Created by Hugues Bousselet on 25/10/2024.
//

import SwiftUI

struct CustomNavigation: ViewModifier {
    @Binding var isGridView: Bool
    @State var onTap: () -> Void
    
    func body(content: Content) -> some View {
        content
        .navigationTitle("Users")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker(selection: $isGridView, label: Text("Display")) {
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
                Button(action: onTap) {
                    Image(systemName: "arrow.clockwise")
                        .imageScale(.large)
                }
            }
        }
    }
}

extension View {
    func applyNavigation(isGridView: Binding<Bool>, onTap: @escaping () -> Void) -> some View {
        modifier(CustomNavigation(isGridView: isGridView, onTap: onTap))
    }
}
