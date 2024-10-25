import SwiftUI

struct UserListView: View {
    @ObservedObject var userModel: UserViewModel
    
    var body: some View {
        NavigationView {
            if !userModel.isGridView {
                ListView(model: userModel)
            } else {
                GridView(model: userModel)
            }
        }
        .onAppear {
            Task {
                await userModel.fetchUsers()
            }
        }
    }
}

struct GridView: View {
    @ObservedObject var model: UserViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(model.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        VStack {
                            HStack {}
                            .imager(userImage: user.picture.medium, width: 150, height: 150)
                            Text("\(user.name.first) \(user.name.last)")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .onAppear {
                        loadMoreUsers(model: model, user: user)
                    }
                }
            }
        }
        .applyNavigation(model: model)
    }
}

struct ListView: View {
    @ObservedObject var model: UserViewModel
    
    var body: some View {
        List(model.users) { user in
            NavigationLink(destination: UserDetailView(user: user)) {
                HStack {
                    HStack {}
                    .imager(userImage: user.picture.thumbnail, width: 50, height: 50)
                    .userInfo(firstname: user.name.first, lastname: user.name.last, date: user.dob.date)
                }
            }
            .onAppear {
                loadMoreUsers(model: model, user: user)
            }
        }
        .applyNavigation(model: model)
    }
}

func loadMoreUsers(model: UserViewModel, user: User) {
    if model.shouldLoadMoreData(currentItem: user) {
        Task {
            await model.fetchUsers()
        }
    }
}
