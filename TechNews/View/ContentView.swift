//
//  ContentView.swift
//  TechNews
//
//  Created by 潘睿龙 on 2026/1/2.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @StateObject var favoritesVM = FavoritesViewModel()
    var body: some View {
        TabView {
            Tab("News", systemImage: "newspaper") {
                News()
            }
            Tab("Favorites", systemImage: "star") {
                FavoritesView()
            }
            Tab("Settings", systemImage: "gear") {
                Settings()
            }
        }
        .environmentObject(favoritesVM)
    }
}

#Preview {
    ContentView()
}
