//
//  OnboardingViewControllerTests.swift
//  
//
//  Created by Hassan Ashraf on 06/03/2023.
//

import XCTest
@testable import VFEOnboardingKit // replace with your project name

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
    
    func testNextButtonDefaultSetup() {
        let expectedTitle = "Next"
        let expectedColor = UIColor.white
        let expectedBackgroundColor = UIColor.red
        let expectedCornerRadius: CGFloat = 25
        
        XCTAssertEqual(sut.testNextButton.title(for: .normal), expectedTitle)
        XCTAssertEqual(sut.testNextButton.backgroundColor, expectedBackgroundColor)
        XCTAssertEqual(sut.testNextButton.titleColor(for: .normal), expectedColor)
        XCTAssertEqual(sut.testNextButton.layer.cornerRadius, expectedCornerRadius)
    }
    
    func testPageControlDefaultSetup() {
        let expectedDotSize: CGFloat = 10
        let expectedDotColor = UIColor.darkGray
        let expectedSelectedColor = UIColor.red
        
        XCTAssertEqual(sut.testPageControl.dotSize, expectedDotSize)
        XCTAssertEqual(sut.testPageControl.dotColor, expectedDotColor)
        XCTAssertEqual(sut.testPageControl.selectedColor, expectedSelectedColor)
    }
    
    func testSkipButtonViewDefaultSetup() {
        let expectedTitle = "Skip"
        let expectedColor = UIColor.white
        
        XCTAssertNotNil(sut.testSkipButton)
        XCTAssertEqual(sut.testSkipButton.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(sut.testSkipButton.title(for: .normal), expectedTitle)
        XCTAssertEqual(sut.testSkipButton.titleColor(for: .normal), expectedColor)
    }
    
    func testInitWithCoder() {
        sut = OnboardingViewController(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    func testViewDidLoad() {
        sut.viewDidLoad()
        
        /// Setup Views
        
        /// Skip Button
        XCTAssertNotNil(sut.testSkipButton)
       
        /// Next Button
        XCTAssertNotNil(sut.testNextButton)
        
        /// PageControl
        XCTAssertNotNil(sut.testPageControl)
        
        
        }
    
    func testSetupPageViewController() {
        // Given
        let expectedCount = mockViewModel.generatePageViewModels().count
        
        // When
        sut.setupPageViewController()
        
        // Then
        XCTAssertEqual(sut.testPages.count, expectedCount)
        XCTAssertTrue(sut.delegate === sut)
        XCTAssertTrue(sut.dataSource === sut)
    }
    
    func testSetupPageControl() {
        // Given
        let expectedCount = mockViewModel.generatePageViewModels().count
        
        // When
        sut.setupPageViewController()
        sut.setupPageControl()
        
        // Then
        XCTAssertEqual(sut.testPageControl.pages, expectedCount)
        XCTAssertEqual(sut.testPageControl.dotSize, 10)
        XCTAssertEqual(sut.testPageControl.dotColor, .darkGray)
        XCTAssertEqual(sut.testPageControl.selectedColor, .red)
    }
    
    func testPageViewControllerDataSource() {
        // Given
        sut.setupPageViewController()
        let initialPage = 0
        
        // When
        let beforePage = sut.pageViewController(sut, viewControllerBefore: sut.testPages[initialPage])
        let afterPage = sut.pageViewController(sut, viewControllerAfter: sut.testPages[initialPage])
        
        // Then
        XCTAssertNil(beforePage)
        XCTAssertTrue(afterPage === sut.testPages[initialPage + 1])
    }
    
}

// MARK: - Mock Objects

class MockOnboardingViewModel: OnboardingViewModelProtocol {
    
    func generatePageViewModels() -> [PageViewModelProtocol] {
        return [
            MockPageViewModel(image: UIImage(), title: "Title 1", subtitle: "Description 1"),
            MockPageViewModel(image: UIImage(), title: "Title 2", subtitle: "Description 2"),
            MockPageViewModel(image: UIImage(), title: "Title 3", subtitle: "Description 3")
        ]
    }
    
}
