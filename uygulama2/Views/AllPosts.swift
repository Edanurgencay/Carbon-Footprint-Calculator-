//
//  AllPosts.swift
//  blogdeneme
//
//  Created by Eda Gencay on 16.05.2024.
//

import SwiftUI
 
struct AllPosts: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(latestpost) {post in
                    NavigationLink(destination: BlogPostView(blogPost: post)) {
                    BlogPostCardList(blogPost: post)
                    }
                }
            }
    
            .listStyle(InsetListStyle())
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("BLOG YAZILARI")
             .font(.custom("RobotoSlab-Regular", size: 20))
             .foregroundColor(.primary)
                                    }
                
            }
        }
    }
}
 
struct AllPosts_Previews: PreviewProvider {
    static var previews: some View {
        AllPosts()
    }
}
