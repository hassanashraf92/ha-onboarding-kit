//
//  NextButtonStyleTests.swift
//  
//
//  Created by Hassan Ashraf on 06/03/2023.
//

import XCTest
@testable import VFEOnboardingKit

class NextButtonStylerTests: XCTestCase {
    
    func testStyle_whenDelegateIsSet_shouldUseDelegateStyle() {
        // given
        let expectedStyle = ButtonStyle(cornerRadius: 20, backgroundColor: .blue, foregroundColor: .white, borderColor: nil, borderWidth: nil)
        let mockDelegate = MockNextButtonStylerDelegate(style: expectedStyle)
        let sut = NextButtonStyler()
        sut.delegate = mockDelegate
        
        // when
        let actualStyle = sut.style
        
        // then
        XCTAssertEqual(actualStyle, expectedStyle)
    }
    
    func testStyle_whenDelegateIsNotSet_shouldUseDefaultStyle() {
        // given
        let expectedStyle = ButtonStyle(cornerRadius: 25, backgroundColor: .red, foregroundColor: .white, borderColor: nil, borderWidth: nil)
        let sut = NextButtonStyler()
        
        // when
        let actualStyle = sut.style
        
        // then
        XCTAssertEqual(actualStyle, expectedStyle)
    }
    
}

class MockNextButtonStylerDelegate: NextButtonStylerProtocol {
    
    let style: ButtonStyle
    
    init(style: ButtonStyle) {
        self.style = style
    }
    
    func createButtonStyle() -> ButtonStyle {
        return style
    }
    
}

