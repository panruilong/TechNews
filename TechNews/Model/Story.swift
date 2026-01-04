//
//  Story.swift
//  TechNews
//
//  Created by 潘睿龙 on 2026/1/2.
//

import Foundation

// 1. 去掉 Codable，只保留 Identifiable, Sendable
struct Story: Identifiable, Sendable, Encodable, Decodable {
    var id: Int
    var title: String
    var url: String?
    var score: Int
    var commentCount: Int?

    // 2. 手动写一个初始化器来解码
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
              let title = json["title"] as? String else {
            return nil
        }

        self.id = id
        self.title = title
        self.url = json["url"] as? String
        self.score = json["score"] as? Int ?? 0
        self.commentCount = json["descendants"] as? Int
    }
    // 这是测试用
    init(id: Int, title: String, url: String?, score: Int, commentCount: Int?) {
        self.id = id
        self.title = title
        self.url = url
        self.score = score
        self.commentCount = commentCount
    }

}
