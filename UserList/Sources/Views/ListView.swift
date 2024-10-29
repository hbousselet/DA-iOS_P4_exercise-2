//
//  ListView.swift
//  UserList
//
//  Created by Hugues Bousselet on 29/10/2024.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var model: UserViewModel
    
    var body: some View {
        List(model.users) { user in
            NavigationLink(destination: UserDetailView(user: user)) {
                HStack {
                    ImageView(userImage: user.picture.thumbnail, width: 50, height: 50)
                    UserInfo(firstname: user.name.first, lastname: user.name.last, date: user.dob.date)
                }
            }
            .onAppear {
                if model.shouldLoadMoreData(currentItem: user) {
                    Task {
                        await model.fetchUsers()
                    }
                }            }
        }
        .applyNavigation(isGridView: $model.isGridView) {
            Task {
                await model.reloadUsers()
            }
        }
    }
}
