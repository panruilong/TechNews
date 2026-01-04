# TechNews

[![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2016.0+-lightgrey.svg)]()
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**A modern iOS news reader app built with SwiftUI, MVVM, and Async/Await.**
TechNews creates a seamless reading experience for Hacker News, featuring concurrent networking, local persistence, and in-app browsing.

> **TechNews** 是一款基于 Hacker News API 开发的现代化 iOS 阅读器。采用 SwiftUI + MVVM 架构，实现了并发网络请求、本地收藏、以及丝滑的交互体验。

---

##  Features (核心亮点)

| Feature                   | Description                                                  |
| ------------------------- | ------------------------------------------------------------ |
| **Concurrent Networking** | Fetches top stories in parallel using `TaskGroup` & `Alamofire` for maximum speed. <br>使用 TaskGroup 实现高并发数据加载。 |
| **MVVM Architecture**     | Clean separation of logic and UI using `ObservableObject` & `@Published`. <br>标准的 MVVM 架构，逻辑与视图分离。 |
| **Robust Persistence**    | Saves your favorite stories locally via `UserDefaults`. <br>本地数据持久化，收藏永不丢失。 |
| **Smooth UX**             | Pull-to-refresh, micro-interactions (bouncing stars), and loading states. <br>下拉刷新、微交互动画、优雅的加载状态。 |
| **Hybrid Development**    | Integrated `SFSafariViewController` using `UIViewControllerRepresentable`. <br>混合开发，集成原生 Safari 浏览体验。 |
| **Code Quality**          | Linted by `SwiftLint` and tested with `XCTest`. <br>代码规范检查与单元测试覆盖。 |

##  Tech Stack (技术栈)

*   **Language:** Swift 5
*   **UI Framework:** SwiftUI (NavigationStack, TabView)
*   **Networking:** Alamofire + Swift Concurrency (Async/Await)
*   **Image Loading:** Kingfisher
*   **Tools:** SwiftLint, SPM, XCTest

##  Screenshots (截图预览)

## 📸 Screenshots

| 首页                      | 网页                     | 收藏                     |
| ------------------------- | ------------------------ | ------------------------ |
| ![](screenshots/home.png) | ![](screenshots/web.png) | ![](screenshots/fav.png) |

##  How to Run (如何运行)

1.  Clone the repository:
    ```bash
    git clone https://github.com/你的用户名/TechNews.git

2.  Open `TechNews.xcodeproj` in Xcode 15+.
3.  Wait for SPM to fetch dependencies (Alamofire, Kingfisher).
4.  Run on Simulator (iPhone 15 Pro recommended).

---

###  Author

**Pan Ruilong**
*   Aspiring iOS Developer
*   Open to job opportunities (Remote / On-site)
