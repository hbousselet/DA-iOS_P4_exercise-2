import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        VStack {
            HStack{}
            .imager(userImage: user.picture.large, width: 200, height: 200)
            .userInfo(firstname: user.name.first, lastname: user.name.last, date: user.dob.date)
            .padding()
            Spacer()
        }
        .navigationTitle("\(user.name.first) \(user.name.last)")
    }
}
