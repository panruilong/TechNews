//
//  FavoritesViewModel.swift
//  TechNews
//
//  Created by 潘睿龙 on 2026/1/3.
//

import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var savedStories: [Story] = [] {
        didSet {
            save()
        }
    }
    private let saveKey = "SavedStories"
    init() {
        load()
    }
    func toggle(_ story: Story) {
        if contains(story) {
            savedStories.removeAll { $0.id == story.id }
        } else {
            savedStories.append(story)
        }
    }
    func contains(_ story: Story) -> Bool {
        return savedStories.contains { $0.id == story.id }
    }
    private func save() {
        if let data = try? JSONEncoder().encode(savedStories) {
            UserDefaults.standard.set(data, forKey: saveKey)
        }
    }
    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Story].self, from: data) {
            savedStories = decoded
        }
    }
}
