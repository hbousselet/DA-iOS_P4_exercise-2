//
//  GridView.swift
//  UserList
//
//  Created by Hugues Bousselet on 29/10/2024.
//

import SwiftUI

struct GridView: View {
    @ObservedObject var model: UserViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(model.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        VStack {
                            ImageView(userImage: user.picture.medium, width: 150, height: 150)
                            Text("\(user.name.first) \(user.name.last)")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .onAppear {
                        if model.shouldLoadMoreData(currentItem: user) {
                            Task {
                                await model.fetchUsers()
                            }
                        }
                    }
                }
            }
        }
        .applyNavigation(isGridView: $model.isGridView) {
            Task {
                await model.reloadUsers()
            }
        }
    }
}
