//
//  PageViewModel.swift
//  
//
//  Created by Hassan Ashraf on 05/03/2023.
//

import Foundation
import UIKit

protocol PageViewModelProtocol {
    var image: UIImage { get }
    var title: String { get }
    var subtitle: String { get }
}

class PageViewModel: PageViewModelProtocol {
    
    var image: UIImage
    var title: String
    var subtitle: String
    
    init(data: VFEOnboardingModel) {
        image = data.image
        title = data.title
        subtitle = data.subtitle
    }
    
}
