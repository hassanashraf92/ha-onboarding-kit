//
//  OnboardingViewModelTests.swift
//  
//
//  Created by Hassan Ashraf on 06/03/2023.
//

import XCTest
@testable import VFEOnboardingKit

class OnboardingViewModelTests: XCTestCase {
    
    var sut: OnboardingViewModel!
    
    override func setUp() {
        super.setUp()
        let data: [VFEOnboardingModel] = [
            VFEOnboardingModel(image: UIImage(), title: "Title 01", subtitle: "Subtitle 01", actionButtonTitle: "Next"),
            VFEOnboardingModel(image: UIImage(), title: "Title 02", subtitle: "Subtitle 02", actionButtonTitle: "Next"),
            VFEOnboardingModel(image: UIImage(), title: "Title 03", subtitle: "Subtitle 03", actionButtonTitle: "Go")
        ]
        sut = OnboardingViewModel(data: data)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testOnboardingViewModel() {
        XCTAssertNotNil(sut)
    }
    
    func testGeneratePageViewModels() {
        let pageViewModels = sut.generatePageViewModels()
        XCTAssertEqual(pageViewModels.count, 3)
    }
    
    func testDidPressSkipButton() {
        let mockDelegate = MockVFEOnboardingNavigationProtocol()
        sut.delegate = mockDelegate
        sut.didPressSkipButton()
        XCTAssertTrue(mockDelegate.didPressSkipButtonCalled)
    }
    
    func testUpdateCurrent() {
        let index = 3
        sut.updateCurrent(index: index)
        XCTAssertEqual(sut.currentPageIndex, index)
    }
    
    func testShouldNavigateToNextPage_ReturnsTrue() {
        sut.currentPageIndex = 1
        XCTAssertTrue(sut.shouldNavigateToNextPage())
    }
    
    func testShouldNavigateToNextPage_ReturnsFalse() {
        sut.currentPageIndex = 2
        XCTAssertFalse(sut.shouldNavigateToNextPage())
    }
    
    func testShouldNavigateToPreviousPage_ReturnsTrue() {
        sut.currentPageIndex = 1
        XCTAssertTrue(sut.shouldNavigateToPreviousPage())
    }
    
    func testShouldNavigateToPreviousPage_ReturnsFalse() {
        sut.currentPageIndex = 0
        XCTAssertFalse(sut.shouldNavigateToPreviousPage())
    }

    func testDidReachLastPage() {
        let mockDelegate = MockVFEOnboardingNavigationProtocol()
        sut.delegate = mockDelegate
        sut.didReachLastPage()
        XCTAssertTrue(mockDelegate.didReachLastPageCalled)
    }

    func testNextButtonTitle_ReturnsNext() {
        sut.currentPageIndex = 0
        XCTAssertEqual(sut.getActionButtonTitle(), "Next")
    }

    func testNextButtonTitle_ReturnsGo() {
        sut.currentPageIndex = 2
        XCTAssertEqual(sut.getActionButtonTitle(), "Go")
    }

    func testSkipButtonTitle_ReturnsSkip() {
        sut.currentPageIndex = 0
        XCTAssertEqual(sut.getSkipButtonTitle(), "Skip")
        sut.currentPageIndex = 1
        XCTAssertEqual(sut.getSkipButtonTitle(), "Skip")
        sut.currentPageIndex = 2
        XCTAssertEqual(sut.getSkipButtonTitle(), "Skip")
    }
}


class MockVFEOnboardingNavigationProtocol: VFEOnboardingNavigationProtocol {
    var didPressSkipButtonCalled = false
    var didReachLastPageCalled = false
    
    func didPressSkipButton() {
        didPressSkipButtonCalled = true
    }
    
    func didReachLastPage() {
        didReachLastPageCalled = true
    }
}
