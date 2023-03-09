//
//  PageViewControllerTests.swift
//
//
//  Created by Hassan Ashraf on 05/03/2023.
//

import XCTest
@testable import VFEOnboardingKit

class PageViewControllerTests: XCTestCase {

    func testInitializationWithViewModel() {
        let viewModel = MockPageViewModel(image: UIImage(), title: "Test Title", subtitle: "Test Subtitle")
        let pageVC = PageViewController(viewModel: viewModel)
        XCTAssertNotNil(pageVC)
        XCTAssertEqual(pageVC.testTitleLabel.text, "Test Title")
        XCTAssertEqual(pageVC.testSubtitleLabel.text, "Test Subtitle")
        XCTAssertEqual(pageVC.testStackView.subviews.count, 2)
    }
    
    func testViewDidLoad() {
        // given
        let viewModel = MockPageViewModel(image: UIImage(), title: "Test Title", subtitle: "Test Subtitle")
        let pageViewController = PageViewController(viewModel: viewModel)
        let _ = pageViewController.view // force load view hierarchy

        // then
        XCTAssertNotNil(pageViewController.view)
        XCTAssertEqual(pageViewController.view.subviews.count, 2)
//        XCTAssertTrue(pageViewController.view.subviews.contains(pageViewController.imageView))
        XCTAssertTrue(pageViewController.view.subviews.contains(pageViewController.testStackView))
//        XCTAssertEqual(pageViewController.imageView.translatesAutoresizingMaskIntoConstraints, false)
//        XCTAssertEqual(pageViewController.imageView.contentMode, .scaleAspectFill)
//        XCTAssertEqual(pageViewController.imageView.clipsToBounds, true)
        XCTAssertEqual(pageViewController.testStackView.axis, .vertical)
        XCTAssertEqual(pageViewController.testStackView.alignment, .center)
        XCTAssertEqual(pageViewController.testStackView.spacing, 8)
        XCTAssertEqual(pageViewController.testTitleLabel.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(pageViewController.testTitleLabel.font, UIFont.boldSystemFont(ofSize: 28))
        XCTAssertEqual(pageViewController.testTitleLabel.textAlignment, .center)
        XCTAssertEqual(pageViewController.testTitleLabel.text, viewModel.title)
        XCTAssertEqual(pageViewController.testSubtitleLabel.translatesAutoresizingMaskIntoConstraints, false)
        XCTAssertEqual(pageViewController.testSubtitleLabel.font, UIFont.systemFont(ofSize: 16))
        XCTAssertEqual(pageViewController.testSubtitleLabel.textAlignment, .center)
        XCTAssertEqual(pageViewController.testSubtitleLabel.numberOfLines, 2)
        XCTAssertEqual(pageViewController.testSubtitleLabel.text, viewModel.subtitle)
    }

}

class MockPageViewModel: PageViewModelProtocol {
    var image: UIImage
    var title: String
    var subtitle: String
    
    init(image: UIImage, title: String, subtitle: String) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
}
