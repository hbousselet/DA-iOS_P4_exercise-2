import SwiftUI

struct UserView: View {
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
