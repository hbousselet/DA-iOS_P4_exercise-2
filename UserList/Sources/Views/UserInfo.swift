//
//  UserInfo.swift
//  UserList
//
//  Created by Hugues Bousselet on 25/10/2024.
//

import SwiftUI

struct UserInfo: View {
    let firstname: String
    let lastname: String
    let date: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(firstname) \(lastname)")
                .font(.headline)
            Text(turnInDate(date: date), style: .date)
                .font(.subheadline)
        }
    }
    
    private func turnInDate(date: String) -> Date  {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: date) ?? Date.now
    }
}
