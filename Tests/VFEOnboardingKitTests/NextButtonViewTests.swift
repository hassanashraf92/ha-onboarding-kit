//
//  NextButtonViewTests.swift
//  
//
//  Created by Hassan Ashraf on 09/03/2023.
//

import XCTest
@testable import VFEOnboardingKit

class NextButtonViewTests: XCTestCase {
    
    var sut: NextButtonView!
    var styler: NextButtonStyler!
    
    override func setUpWithError() throws {
        sut = NextButtonView()
        styler = NextButtonStyler()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        styler = nil
    }
    
    func testNextButtonView_initWithFrame() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        let sut = NextButtonView(frame: frame)
        XCTAssertEqual(sut.frame, frame)
    }
    
        func testInitWithCoder() {
            sut = NextButtonView(coder: NSCoder())
            XCTAssertNil(sut)
        }
    
    func testNextButtonView_backgroundColor() {
        XCTAssertEqual(sut.backgroundColor, styler.style.backgroundColor)
    }
    
    func testNextButtonView_foregroundColor() {
        XCTAssertEqual(sut.titleLabel?.textColor, styler.style.foregroundColor)
    }
    
    func testNextButtonView_cornerRadius() {
        XCTAssertEqual(sut.layer.cornerRadius, styler.style.cornerRadius)
    }
    
    func testNextButtonView_onButtonPressed() {
        XCTAssertNotNil(sut)
        guard let sutActions = sut.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
            return
        }
        
        XCTAssertTrue(sutActions.contains("nextButtonTapped"))
        
    }
    
}
