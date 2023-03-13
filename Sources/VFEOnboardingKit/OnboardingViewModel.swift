//
//  OnboardingViewModel.swift
//  
//
//  Created by Hassan Ashraf on 06/03/2023.
//

import Foundation

protocol OnboardingViewModelProtocol {
    var initialPageIndex: Int { get }
    var currentPageIndex: Int { get }
    func generatePageViewModels() -> [PageViewModelProtocol]
    func didPressSkipButton()
    func updateCurrent(index: Int)
    func shouldNavigateToNextPage() -> Bool
    func shouldNavigateToPreviousPage() -> Bool
    func didReachLastPage()
    func getActionButtonTitle() -> String
    func getSkipButtonTitle() -> String
}

class OnboardingViewModel: OnboardingViewModelProtocol {
    
    var initialPageIndex: Int = 0
    var currentPageIndex: Int = 0
    private var totalPagesCount: Int = 0
    
    let data: [VFEOnboardingModel]
    weak var delegate: VFEOnboardingNavigationProtocol?
    
    init(data: [VFEOnboardingModel]) {
        self.data = data
        self.delegate = VFEOnboardingKit.navigationDelegate
        self.totalPagesCount = data.count
    }
    
    func generatePageViewModels() -> [PageViewModelProtocol] {
        return data.map { PageViewModel(data: $0) }
    }
    
    func didPressSkipButton() {
        delegate?.didPressSkipButton()
    }
    
    func updateCurrent(index: Int) {
        self.currentPageIndex = index
    }
    
    func shouldNavigateToNextPage() -> Bool {
        return currentPageIndex < totalPagesCount - 1
    }
    
    func shouldNavigateToPreviousPage() -> Bool {
        return currentPageIndex != 0
    }
    
    func didReachLastPage() {
        delegate?.didReachLastPage()
    }
    
    func getActionButtonTitle() -> String {
        guard currentPageIndex < data.count else { return "" }
        return data[currentPageIndex].actionButtonTitle
    }
    
    func getSkipButtonTitle() -> String {
        guard currentPageIndex < data.count else { return "" }
        return data[currentPageIndex].skipButtonTitle
    }
}
