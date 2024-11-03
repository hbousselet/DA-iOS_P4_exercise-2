//
//  Imager.swift
//  UserList
//
//  Created by Hugues Bousselet on 25/10/2024.
//

import SwiftUI

struct ImageView: View {
    let userImage: String
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: userImage)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
                .frame(width: width, height: height)
                .clipShape(Circle())
        }
    }
    
}

