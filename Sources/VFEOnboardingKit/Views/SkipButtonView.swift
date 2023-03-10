//
//  SkipButtonView.swift
//  
//
//  Created by Hassan Ashraf on 09/03/2023.
//

import UIKit

class SkipButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(.black, for: .normal)
        self.setTitle("Skip", for: .normal)
        self.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    var onButtonPressed: (() -> Void)?
    
    @objc private func buttonPressed() {
        onButtonPressed?()
    }
    
}
