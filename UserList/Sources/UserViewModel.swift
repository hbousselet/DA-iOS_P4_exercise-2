//
//  UserViewModel.swift
//  UserList
//
//  Created by Hugues Bousselet on 23/10/2024.
//

import Foundation
import SwiftUI

final class UserViewModel: ObservableObject {
    //shall both be published vars. It lets our view knows when their values have changed
    @Published var users: [User] = []
    @Published var isGridView = false
    @Published var isLoading = false
    
    var repository: UserListRepository
    
    init(repository: UserListRepository) {
        self.repository = repository
    }
    
    // TODO: - Should be a viewModel's input
    @MainActor
    func fetchUsers() async {
        isLoading = true
        // should return to main thread for published properties
        do {
            let fetchedUsers = try await repository.fetchUsers(quantity: 20)
            // should return to main thread for published property
            self.users.append(contentsOf: fetchedUsers)
            self.isLoading = false
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
    }

    // TODO: - Should be an OutPut
    func shouldLoadMoreData(currentItem item: User) -> Bool {
        guard let lastItem = users.last else { return false }
        return !isLoading && item.id == lastItem.id
    }

    // TODO: - Should be a viewModel's input
    @MainActor
    func reloadUsers() async {
        users.removeAll()
        await fetchUsers()
        print(self.users)
    }
}
