//
//  SkipButtonViewTests.swift
//  
//
//  Created by Hassan Ashraf on 09/03/2023.
//

import XCTest
@testable import VFEOnboardingKit

class SkipButtonViewTests: XCTestCase {
    
    var sut: SkipButtonView!
    
    override func setUpWithError() throws {
        sut = SkipButtonView()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testNextButtonView_initWithFrame() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        let sut = SkipButtonView(frame: frame)
        XCTAssertEqual(sut.frame, frame)
    }
    
        func testInitWithCoder() {
            sut = SkipButtonView(coder: NSCoder())
            XCTAssertNil(sut)
        }
    
    func testNextButtonView_backgroundColor() {
        XCTAssertEqual(sut.backgroundColor, nil)
    }
    
    func testNextButtonView_foregroundColor() {
        XCTAssertEqual(sut.titleLabel?.textColor, .black)
    }
    
    func testSkipButtonViewTitle() {
        XCTAssertEqual(sut.titleLabel?.text, "Skip")
    }
    
    func testNextButtonView_onButtonPressed() {
        XCTAssertNotNil(sut)
        guard let sutActions = sut.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
            return
        }
        
        print("SUT ACTIONS", sutActions)
        
        XCTAssertTrue(sutActions.contains("buttonPressed"))
        
    }
    
}
