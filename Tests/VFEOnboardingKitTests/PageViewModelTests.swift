//
//  PageViewModelTests.swift
//  
//
//  Created by Hassan Ashraf on 05/03/2023.
//

import XCTest
@testable import VFEOnboardingKit

class PageViewModelTests: XCTestCase {

    var sut: PageViewModel!
    var testData: VFEOnboardingModel!

    override func setUp() {
        super.setUp()
        testData = VFEOnboardingModel(image: UIImage(), title: "Test Title", subtitle: "Test Subtitle")
        sut = PageViewModel(data: testData)
    }

    override func tearDown() {
        testData = nil
        sut = nil
        super.tearDown()
    }

    func testInitWithData() {
        XCTAssertEqual(sut.title, testData.title)
        XCTAssertEqual(sut.subtitle, testData.subtitle)
    }
}
