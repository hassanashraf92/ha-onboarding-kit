//
//  VFEPageControlTests.swift
//  
//
//  Created by Hassan Ashraf on 05/03/2023.
//

import XCTest
@testable import VFEOnboardingKit

class VFEPageControlTests: XCTestCase {
    
    var pageControl: VFEPageControl!
    
    override func setUp() {
        super.setUp()
        pageControl = VFEPageControl()
        pageControl.pages = 5
    }
    
    override func tearDown() {
        pageControl = nil
        super.tearDown()
    }
    
    func testInitWithFrame() {
        pageControl = VFEPageControl(frame: .zero)
        XCTAssertEqual(pageControl.frame.size, .zero)
    }
    
    func testInitWithCoder() {
        // Given
        let archive = NSKeyedArchiver.archivedData(withRootObject: VFEPageControl())
        let unarchived = NSKeyedUnarchiver.unarchiveObject(with: archive) as? VFEPageControl
        
        // Then
        XCTAssertNotNil(unarchived)
    }

    func testLayoutSubviews() {
        let pageControl = makeSUT()
        
        XCTAssertEqual(pageControl.dotViews.count, 5)
        XCTAssertEqual(pageControl.dotViews[0].frame.size.width, 10)
        XCTAssertEqual(pageControl.dotViews[0].frame.size.height, 10)
        XCTAssertEqual(pageControl.dotViews[0].center.x, 5)
        XCTAssertEqual(pageControl.dotViews[0].center.y, 5)
        
        // Check that the updatePositions() method is called
        pageControl.bounds = CGRect(x: 0, y: 0, width: 200, height: 100) //Changed the height to check if layoutSubViews is called!
        // Check that the positions of the dots are updated correctly
        // You can access the dotViews array to check the positions of the dots
        // For example, you could check that the first dot has the correct center
        XCTAssertEqual(pageControl.dotViews.count, 5)
        XCTAssertEqual(pageControl.dotViews[0].frame.size.width, 10)
        XCTAssertEqual(pageControl.dotViews[0].frame.size.height, 10)
        XCTAssertEqual(pageControl.dotViews[0].center.x, 5)
        XCTAssertEqual(pageControl.dotViews[0].center.y, 5)
        
    }

    
    func testNumberOfPages() {
        XCTAssertEqual(pageControl.pages, 5)
    }
    
    func testSelectedPage() {
        pageControl.selectedPage = 2
        XCTAssertEqual(pageControl.selectedPage, 2)
    }
    
    func testMaxDots() {
        pageControl.maxDots = 10
        XCTAssertEqual(pageControl.maxDots, 11)
        
        pageControl.maxDots = 3
        XCTAssertEqual(pageControl.maxDots, 3)
    }
    
    func testCenterDots() {
        pageControl.centerDots = 3
        XCTAssertEqual(pageControl.centerDots, 3)
        
        pageControl.centerDots = 2
        XCTAssertEqual(pageControl.centerDots, 3)
    }
    
    func testDotSize() {
        pageControl.dotSize = 10
        XCTAssertEqual(pageControl.dotSize, 10)
    }
    
    func testSpacing() {
        pageControl.spacing = 10
        XCTAssertEqual(pageControl.spacing, 10)
    }
    
    func testCreateViews() {
        XCTAssertEqual(pageControl.dotViews.count, 5)
    }
    
    func testUpdateColors() {
        pageControl.selectedColor = .red
        pageControl.dotColor = .lightGray
        pageControl.selectedPage = 2
        
        pageControl.dotViews = [UIView(), UIView(), UIView(), UIView(), UIView()]
        
        XCTAssertEqual(pageControl.dotViews[0].tintColor, UIColor.lightGray)
        XCTAssertEqual(pageControl.dotViews[1].tintColor, UIColor.lightGray)
        XCTAssertEqual(pageControl.dotViews[2].tintColor, UIColor.red)
        XCTAssertEqual(pageControl.dotViews[3].tintColor, UIColor.lightGray)
        XCTAssertEqual(pageControl.dotViews[4].tintColor, UIColor.lightGray)
    }
    
    func testUpdatePositions_WithThreeItems() {
        pageControl.pages = 3
        pageControl.centerDots = 3
        pageControl.maxDots = 3
        
        pageControl.dotSize = 10
        pageControl.spacing = 5
        pageControl.bounds = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        // Call the updatePositions method
        pageControl.updatePositions()
        
        // Check that the dot views have been updated correctly
        XCTAssertEqual(pageControl.dotViews.count, 3)
        XCTAssertEqual(pageControl.dotViews[0].frame.size.width, 10)
        XCTAssertEqual(pageControl.dotViews[0].frame.size.height, 10)
        XCTAssertEqual(pageControl.dotViews[0].center.x, 35)
        XCTAssertEqual(pageControl.dotViews[0].center.y, 25)
        XCTAssertEqual(pageControl.dotViews[1].frame.size.width, 10)
        XCTAssertEqual(pageControl.dotViews[1].frame.size.height, 10)
        XCTAssertEqual(pageControl.dotViews[1].center.x, 50, accuracy: 0.1)
        XCTAssertEqual(pageControl.dotViews[1].center.y, 25)
        XCTAssertEqual(pageControl.dotViews[2].frame.size.width, 10)
        XCTAssertEqual(pageControl.dotViews[2].frame.size.height, 10)
        XCTAssertEqual(pageControl.dotViews[2].center.x, 65, accuracy: 0.1)
        XCTAssertEqual(pageControl.dotViews[2].center.y, 25)
    }
    
    func testUpdatePositions_WithMoreThanThreeItems() {
        
        // Set up the VFEPageControl with some sample data
        pageControl.pages = 5
        pageControl.centerDots = 3
        pageControl.maxDots = 5
        
        pageControl.dotSize = 10
        pageControl.spacing = 5
        pageControl.bounds = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        // Call the updatePositions method
        pageControl.updatePositions()
        
        // Check that the dot views have been updated correctly
        XCTAssertEqual(pageControl.dotViews.count, 5)
        XCTAssertEqual(pageControl.dotViews[0].frame.size.width, 10)
        XCTAssertEqual(pageControl.dotViews[0].frame.size.height, 10)
        XCTAssertEqual(pageControl.dotViews[0].center.x, 35)
        XCTAssertEqual(pageControl.dotViews[0].center.y, 25)
        XCTAssertEqual(pageControl.dotViews[1].frame.size.width, 10)
        XCTAssertEqual(pageControl.dotViews[1].frame.size.height, 10)
        XCTAssertEqual(pageControl.dotViews[1].center.x, 50, accuracy: 0.1)
        XCTAssertEqual(pageControl.dotViews[1].center.y, 25)
        XCTAssertEqual(pageControl.dotViews[2].frame.size.width, 10)
        XCTAssertEqual(pageControl.dotViews[2].frame.size.height, 10)
        XCTAssertEqual(pageControl.dotViews[2].center.x, 65, accuracy: 0.1)
        XCTAssertEqual(pageControl.dotViews[2].center.y, 25)
        XCTAssertEqual(pageControl.dotViews[3].frame.size.width, 6.6, accuracy: 0.1)
        XCTAssertEqual(pageControl.dotViews[3].frame.size.height, 6.6, accuracy: 0.1)
        XCTAssertEqual(pageControl.dotViews[4].frame.size.width, 0)
        XCTAssertEqual(pageControl.dotViews[4].frame.size.height, 0)
    }
    
    // MARK: - Helper Functions
    func makeSUT() -> VFEPageControl {
        let pageControl = VFEPageControl(frame: .zero)
        pageControl.pages = 5
        pageControl.centerDots = 3
        pageControl.maxDots = 5
        pageControl.dotSize = 10
        pageControl.spacing = 5
        pageControl.bounds = .zero
        return pageControl
    }
    
}
