//
//  News1.swift
//  TechNews
//
//  Created by 潘睿龙 on 2026/1/6.
//

import SwiftUI
import Kingfisher

struct News1 {
    @StateObject var viewModel = NewsViewModel()
    @State private var selectedStory: Story?

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("正在加载...")
                } else {
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.stories) { story in
                                NewsCardView(story: story)
                                    .onTapGesture {
                                        selectedStory = story
                                    }
                            }
                        }
                        .padding()
                    }
                    .refreshable {
                        await viewModel.fetchTopStories()
                    }
                }
            }
            .navigationTitle("Tech News")
            .background(Color(.systemGroupedBackground))
            .task {
                await viewModel.fetchTopStories()
            }
            .fullScreenCover(item: $selectedStory) { story in
                if let urlString = story.url, let  _ = URL(string: urlString) {
                    NavigationStack {
                        StoryDetailView(story: story)
                    }
                } else {
                    VStack {
                        Text("这条新闻没有链接 😅")
                        Button("关闭") {
                            selectedStory = nil
                        }
                    }
                }
            }
        }
    }
}
