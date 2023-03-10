//
//  VFEOnboardingKitTests.swift
//  
//
//  Created by Hassan Ashraf on 06/03/2023.
//

import XCTest
@testable import VFEOnboardingKit

class VFEOnboardingKitTests: XCTestCase {
    
    var sut: VFEOnboardingKit!
    var rootViewController: UIViewController!
    
    override func setUp() {
        super.setUp()
        let data: [VFEOnboardingModel] = [
            VFEOnboardingModel(image: UIImage(), title: "Title 1", subtitle: "Subtitle 1"),
            VFEOnboardingModel(image: UIImage(), title: "Title 2", subtitle: "Subtitle 2"),
            VFEOnboardingModel(image: UIImage(), title: "Title 3", subtitle: "Subtitle 3"),
            VFEOnboardingModel(image: UIImage(), title: "Title 4", subtitle: "Subtitle 4"),
            VFEOnboardingModel(image: UIImage(), title: "Title 5", subtitle: "Subtitle 5"),
        ]
        sut = VFEOnboardingKit(data: data)
        rootViewController = UIViewController()
    }
    
    override func tearDown() {
        sut = nil
        rootViewController = nil
        super.tearDown()
    }
    
    func testLaunchOnboardingKit() {
        sut.launchOnboarding(rootViewController: rootViewController)
    }
}
