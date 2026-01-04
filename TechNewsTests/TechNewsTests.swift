//
//  TechNewsTests.swift
//  TechNewsTests
//
//  Created by 潘睿龙 on 2026/1/4.
//

import XCTest
// 👇 这里的 @testable import TechNews 很重要
// 意思是：允许测试代码访问 App 里的内部类（哪怕没有 public）
@testable import TechNews

final class FavoritesViewModelTests: XCTestCase {

    var viewModel: FavoritesViewModel!

    // 1. setUp: 每次跑测试之前，都会执行这个
    // 就像做饭前先洗锅
    override func setUp() {
        super.setUp()
        // 每次都创建一个全新的 ViewModel，保证测试环境是干净的
        // 注意：由于我们用了 UserDefaults，真实环境里最好先清空 UserDefaults
        // 但为了简单，我们先假设初始状态是空的
        viewModel = FavoritesViewModel()

        // 强行清空一下，防止上次测试残留
        viewModel.savedStories = []
    }

    // 2. tearDown: 每次跑完测试，执行这个
    // 就像吃完饭洗碗
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // 3. 测试“添加收藏”功能
    // 函数名必须以 test 开头，否则 Xcode 不认
    func testToggleShouldAddStoryWhenNotSaved() {
        // Given (准备数据)
        let story = Story(id: 1001, title: "Test Story", url: nil, score: 0, commentCount: 0)
        // When (执行动作)
        viewModel.toggle(story)
        // Then (验证结果)
        // 断言：我敢打赌，现在数组里应该有 1 个元素
        XCTAssertEqual(viewModel.savedStories.count, 1)
        // 断言：那个元素的 ID 应该是 1001
        XCTAssertEqual(viewModel.savedStories.first?.id, 1001)
    }
    // 4. 测试“取消收藏”功能
    func testToggleShouldRemoveStoryWhenAlreadySaved() {
        // Given
        let story = Story(id: 1002, title: "Test Story 2", url: nil, score: 0, commentCount: 0)
        // 先手动加进去
        viewModel.savedStories = [story]
        // When (再次 toggle，应该是删除)
        viewModel.toggle(story)
        // Then
        XCTAssertTrue(viewModel.savedStories.isEmpty, "数组应该是空的")
    }
}
