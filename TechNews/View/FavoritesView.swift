//
//  Favorites.swift
//  TechNews
//
//  Created by 潘睿龙 on 2026/1/2.
//
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesVM: FavoritesViewModel
    @State private var selectedStory: Story?
    var body: some View {
        NavigationStack {
            List(favoritesVM.savedStories) { story in
                Text(story.title)
                    .onTapGesture {
                        selectedStory = story
                    }
            }
            .navigationTitle("我的收藏")
            .fullScreenCover(item: $selectedStory) { story in
                if let urlString = story.url, let url = URL(string: urlString) {
                    SafariView(url: url).ignoresSafeArea()
                }
            }
            .overlay {
                if favoritesVM.savedStories.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "tray.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("还没收藏任何新闻")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}
