//
//  BlogPostCardList.swift
//  blogdeneme
//
//  Created by Eda Gencay on 16.05.2024.
//

import SwiftUI
 
struct BlogPostCardList: View {
     
    var blogPost: BlogPosts
     
    var body: some View {
        VStack(alignment: .leading) {
            Image(blogPost.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 180)
                .frame(maxWidth: UIScreen.main.bounds.width - 60)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            VStack(spacing: 6) {
                HStack {
                    Text(blogPost.name)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(3)
                        .font(.custom("RobotoSlab-Regular_Bold", size: 25))
                        .font(Font.title2.bold())
                        .foregroundColor(.primary)
                    Spacer()
                }
 
                HStack {
                    Text(blogPost.details)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(3)
                        .font(.custom("RobotoSlab-Regular", size: 15))
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 60, alignment: .leading)
        .padding()
    }
}
 
struct BlogPostCardList_Previews: PreviewProvider {
    static var previews: some View {
        BlogPostCardList(blogPost: BlogPosts(id: 1, name: "Adobo", image: "1", details: "Sample Details"))
    }
}
