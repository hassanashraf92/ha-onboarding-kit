//
//  File.swift
//  
//
//  Created by Hassan Ashraf on 05/03/2023.
//

import Foundation

import XCTest
@testable import VFEOnboardingKit

class CircularViewTests: XCTestCase {

    var circularView: CircularView!

    override func setUpWithError() throws {
        circularView = CircularView()
    }

    override func tearDownWithError() throws {
        circularView = nil
    }
    
    func testLayoutSubViews() {
        circularView.layer.cornerRadius = 10
        circularView.layoutIfNeeded()
        XCTAssertEqual(circularView.layer.cornerRadius, 10, accuracy: 0.001)
    }

    func testCornerRadius() throws {
        circularView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        XCTAssertEqual(circularView.layer.cornerRadius, 25.0)
        
        circularView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        XCTAssertEqual(circularView.layer.cornerRadius, 50.0)
    }

    func testTintColor() throws {
        circularView.tintColor = UIColor.red
        XCTAssertEqual(circularView.backgroundColor, UIColor.red)
        
        circularView.tintColor = UIColor.blue
        XCTAssertEqual(circularView.backgroundColor, UIColor.blue)
    }

}
