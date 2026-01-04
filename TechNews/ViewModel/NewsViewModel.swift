//
//  NewsViewModel.swift
//  TechNews
//
//  Created by 潘睿龙 on 2026/1/2.
//
import Foundation
import Alamofire
import Combine

@MainActor
class NewsViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var isLoading = false
    init() {
        print("ViewModel被创建了")
    }
    deinit {
        print(" NewsViewModel 被成功释放了,没有内存泄漏！")
    }
    func fetchTopStories() async {
        if stories.isEmpty {
            isLoading = true
        }
        guard let ids = try? await AF.request("https://hacker-news.firebaseio.com/v0/topstories.json")
            .serializingDecodable([Int].self).value else {
            isLoading = false
            return
        }
        let top20IDs = Array(ids.prefix(20))
        var tempStories: [Story] = []
        await withTaskGroup(of: Story?.self) { group in
            for id in top20IDs {
                group.addTask {
                    let detailUrl = "https://hacker-news.firebaseio.com/v0/item/\(id).json"
                    guard let data = try? await AF.request(detailUrl).serializingData().value,
                          let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        return nil
                    }
                    return await Story(json: json)
                }
            }
            for await story in group {
                if let story = story {
                    tempStories.append(story)
                }
            }
        }
        let sortedStories = top20IDs.compactMap { id in
            tempStories.first { $0.id == id }
        }
        try? await Task.sleep(nanoseconds: 500_000_000)
        self.stories = sortedStories
        self.isLoading = false
    }
}
