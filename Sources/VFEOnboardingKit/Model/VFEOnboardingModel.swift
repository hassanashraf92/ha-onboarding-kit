//
//  VFEOnboardingModel.swift
//  
//
//  Created by Hassan Ashraf on 04/03/2023.
//

import UIKit

/**
`VFEOnboardingModel` is the model that is responsible for creating `PageViewController` for values provided.
 It's required in order to launch the `PageViewController` by injecting an array of it into `VFEOnboardingKit`
*/

public struct VFEOnboardingModel {
    let image: UIImage
    let title: String
    let subtitle: String
    
    public init(image: UIImage, title: String, subtitle: String) {
        self.image = image
        self.title = title
        self.subtitle = subtitle
    }
}
