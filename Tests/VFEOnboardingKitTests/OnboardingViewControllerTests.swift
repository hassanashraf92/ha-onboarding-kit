//
//  OnboardingViewControllerTests.swift
//
//
//  Created by Hassan Ashraf on 06/03/2023.
//

import XCTest
@testable import VFEOnboardingKit

class OnboardingViewControllerTests: XCTestCase {

    var sut: OnboardingViewController!
    let mockViewModel = MockOnboardingViewModel()
    
    override func setUpWithError() throws {
        sut = OnboardingViewController(
            viewModel: mockViewModel,
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil)
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testInitWithCoder_ReturnsNil() {
        sut = OnboardingViewController(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func testViewDidLoad() {
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.testSkipButton)
        XCTAssertNotNil(sut.testNextButton)
        XCTAssertNotNil(sut.testPageControl)
        XCTAssertNotNil(sut.testPages)
    }
    
    func testPageControlDefaultSetup() {
        let expectedDotSize: CGFloat = 10
        let expectedDotColor = UIColor.darkGray
        let expectedSelectedColor = UIColor.red
        
        XCTAssertEqual(sut.testPageControl.dotSize, expectedDotSize)
        XCTAssertEqual(sut.testPageControl.dotColor, expectedDotColor)
        XCTAssertEqual(sut.testPageControl.selectedColor, expectedSelectedColor)
    }
    
    func testSetupPageViewController() {
        sut.loadViewIfNeeded()
        
        XCTAssertTrue(sut.delegate === sut)
        XCTAssertTrue(sut.dataSource === sut)
        
    }
    
    func testSetupPageControl_countReturnsThree() {
        let expectedCount = mockViewModel.generatePageViewModels().count
        XCTAssertEqual(expectedCount, 3)
    }
    
    func testSetupPageControlView() {
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.testPageControl.pages, 3)
        XCTAssertEqual(sut.testPageControl.dotSize, 10)
        XCTAssertEqual(sut.testPageControl.dotColor, .darkGray)
        XCTAssertEqual(sut.testPageControl.selectedColor, .red)
    }
    
    func testPageViewControllerDataSource() {
        sut.loadViewIfNeeded()
        
        let initialPage = mockViewModel.initialPageIndex
        let pageBefore = sut.pageViewController(sut, viewControllerBefore: sut.testPages[initialPage])
        let pageAfter = sut.pageViewController(sut, viewControllerAfter: sut.testPages[initialPage])
        
        XCTAssertNil(pageBefore)
        XCTAssertNotNil(pageAfter === sut.testPages[initialPage + 1])
    }
    
}

// MARK: - Mock Objects

class MockOnboardingViewModel: OnboardingViewModelProtocol {
    
    var initialPageIndex: Int = 0
    var currentPageIndex: Int = 0
    private var data: [VFEOnboardingModel] = []
    private var totalPagesCount: Int = 0
    
    init() {
        self.data = [
            VFEOnboardingModel(image: UIImage(), title: "Title 01", subtitle: "Subtitle 01", actionButtonTitle: "Next"),
            VFEOnboardingModel(image: UIImage(), title: "Title 02", subtitle: "Subtitle 02", actionButtonTitle: "Next"),
            VFEOnboardingModel(image: UIImage(), title: "Title 03", subtitle: "Subtitle 03", actionButtonTitle: "Go")
        ]
        self.totalPagesCount = 3
    }
    
    func didPressSkipButton() {
        print("did press skip button!")
    }
    
    func updateCurrent(index: Int) {
        currentPageIndex = index
    }
    
    func shouldNavigateToNextPage() -> Bool {
        return currentPageIndex < totalPagesCount - 1
    }
    
    func shouldNavigateToPreviousPage() -> Bool {
        return currentPageIndex != 0
    }
    
    func didReachLastPage() {
        print("Did reach last page!")
    }
    
    func getActionButtonTitle() -> String {
        return data[currentPageIndex].actionButtonTitle
    }
    
    func getSkipButtonTitle() -> String {
        return data[currentPageIndex].skipButtonTitle
    }
    
    func generatePageViewModels() -> [PageViewModelProtocol] {
        return [
            MockPageViewModel(image: UIImage(), title: "Title 1", subtitle: "Description 1"),
            MockPageViewModel(image: UIImage(), title: "Title 2", subtitle: "Description 2"),
            MockPageViewModel(image: UIImage(), title: "Title 3", subtitle: "Description 3")
        ]
    }

}
