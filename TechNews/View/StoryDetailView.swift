//
//  StoryDetailView1.swift
//  TechNews
//
//  Created by 潘睿龙 on 2026/1/6.
//

import SwiftUI
import SwiftData
import Kingfisher

struct StoryDetailView1: View {
    let story: Story
    var animation: Namespace.ID
    @Environment(\.modelContext) private var context
    @Query var savedStories: [SavedStory]
    @Environment(\.dismiss) var dismiss
    var isSaved: Bool {
        savedStories.contains { $0.id == story.id }
    }
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                KFImage(URL(string: "https://robohash.org/\(story.id)?set=set4"))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.1))
                    .matchedGeometryEffect(id: story.id, in: animation)

                Button {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        dismiss()
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.gray.opacity(0.8))
                        .padding()
                }
            }

            HStack {
                Text(story.title)
                    .font(.title2)
                    .bold()
                Spacer()
                Button{
                    toggleSave()
                } label: {
                    Image(systemName: isSaved ?  "bookmark.fill" : "bookmark")
                        .font(.title2)
                        .foregroundStyle(isSaved ? .blue : .gray)
                }
            }
            .padding()

            if let urlStr = story.url, let validURL = URL(string: urlStr) {
                SafariView(url: validURL)
                    .transition(.opacity)
            }
        }
        .background(Color.white)

    }
    func toggleSave() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        if isSaved {
            if let item = savedStories.first(where: { $0.id == story.id }) {
                context.delete(item)
            }
        } else {
            let newItem = SavedStory(from: story)
            context.insert(newItem)
        }
    }
}
