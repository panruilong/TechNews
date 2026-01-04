//
//  News.swift
//  TechNews
//
//  Created by 潘睿龙 on 2026/1/2.
//
import SwiftUI
import Kingfisher

struct News: View {
    @StateObject var viewModel = NewsViewModel()
    @State private var selectedStory: Story?
    @EnvironmentObject var favoritesVM: FavoritesViewModel
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("正在加载...")
                } else {
                    List(viewModel.stories) { story in
                        HStack(spacing: 12) {
                            KFImage(URL(string: "https://robohash.org/\(story.id)?set=set4"))
                                .placeholder {
                                    Circle().fill(Color.gray.opacity(0.1))
                                }
                                .fade(duration: 0.25)
                                .cacheOriginalImage()
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Circle())
                            Button {
                                self.selectedStory = story
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(story.title)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text("By: \(story.score) points")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            Spacer()
                            Image(systemName: favoritesVM.contains(story) ? "star.fill" : "star")
                                .foregroundColor(favoritesVM.contains(story) ? .yellow : .gray)
                                .symbolEffect(.bounce, value: favoritesVM.contains(story))
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                                        favoritesVM.toggle(story)
                                    }
                                }
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await viewModel.fetchTopStories()
                    }
                }
            }
            .navigationTitle("Tech News")
            .task {
                await viewModel.fetchTopStories()
            }
            .fullScreenCover(item: $selectedStory) { story in
                if let urlString = story.url, let url = URL(string: urlString) {
                    SafariView(url: url)
                        .ignoresSafeArea()
                } else {
                    Text("这条新闻没有链接")
                }
            }
        }
    }
}
