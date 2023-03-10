//
//  File.swift
//  
//
//  Created by Hassan Ashraf on 05/03/2023.
//

import UIKit

public struct ButtonStyle: Equatable {
    let cornerRadius: CGFloat
    let backgroundColor: UIColor
    let foregroundColor: UIColor
    let borderColor: UIColor?
    let borderWidth: CGFloat?
    
    public init(
        cornerRadius: CGFloat,
        backgroundColor: UIColor,
        foregroundColor: UIColor,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat? = nil) {
            self.cornerRadius = cornerRadius
            self.backgroundColor = backgroundColor
            self.foregroundColor = foregroundColor
            self.borderColor = borderColor
            self.borderWidth = borderWidth
        }
}

public protocol NextButtonStylerProtocol: AnyObject {
    func createButtonStyle() -> ButtonStyle
}

class NextButtonStyler {
    
    weak var delegate: NextButtonStylerProtocol?
    
    init() {
        self.delegate = VFEOnboardingKit.nextButtonStyler
    }
    
    var style: ButtonStyle {
        if let delegate = delegate {
            return delegate.createButtonStyle()
        } else {
            return createButtonStyle()
        }
    }
    
}

extension NextButtonStyler: NextButtonStylerProtocol {
    func createButtonStyle() -> ButtonStyle {
        let styling = ButtonStyle(
            cornerRadius: 25,
            backgroundColor: .red,
            foregroundColor: .white,
            borderColor: nil,
            borderWidth: nil)
        return styling
    }
}
