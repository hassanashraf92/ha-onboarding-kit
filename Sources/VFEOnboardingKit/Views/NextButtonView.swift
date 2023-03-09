//
//  NextButtonView.swift
//  
//
//  Created by Hassan Ashraf on 09/03/2023.
//

import UIKit

class NextButtonView: UIButton {
    
    private let styler = NextButtonStyler()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = styler.style.cornerRadius
        self.backgroundColor = styler.style.backgroundColor
        self.setTitleColor(styler.style.foregroundColor, for: .normal)
        self.layer.borderWidth = styler.style.borderWidth ?? 0
        self.layer.borderColor = styler.style.borderColor?.cgColor
        self.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Closure that will be called when the button is tapped
    var onButtonPressed: (() -> Void)?
    
    @objc private func nextButtonTapped() {
        onButtonPressed?()
    }

}
