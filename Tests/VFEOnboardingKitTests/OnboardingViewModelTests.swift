//
//  OnboardingViewModelTests.swift
//  
//
//  Created by Hassan Ashraf on 06/03/2023.
//

import XCTest
@testable import VFEOnboardingKit

class OnboardingViewModelTests: XCTestCase {
    
    func testGeneratePageViewModels() {
        // Create some test data
        let testData = [
            VFEOnboardingModel(image: UIImage(), title: "Title 1", subtitle: "Subtitle 1"),
            VFEOnboardingModel(image: UIImage(), title: "Title 2", subtitle: "Subtitle 2")
        ]
        
        // Create an instance of OnboardingViewModel with the test data
        let viewModel = OnboardingViewModel(data: testData)
        
        // Generate page view models
        let pageViewModels = viewModel.generatePageViewModels()
        
        // Check that the generated page view models match the test data
        XCTAssertEqual(pageViewModels.count, testData.count, "Number of generated page view models should match number of test data")
        for i in 0..<testData.count {
            XCTAssertEqual(pageViewModels[i].title, testData[i].title, "Title of generated page view model should match title of test data")
            XCTAssertEqual(pageViewModels[i].subtitle, testData[i].subtitle, "Subtitle of generated page view model should match subtitle of test data")
            XCTAssertEqual(pageViewModels[i].image, testData[i].image, "Image name of generated page view model should match image name of test data")
        }
    }
}

