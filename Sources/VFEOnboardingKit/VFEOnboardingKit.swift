//
//  VFEOnboardingKit.swift
//  
//
//  Created by Hassan Ashraf on 03/03/2023.
//

import UIKit

public class VFEOnboardingKit {
    
    // MARK: - Styling
    
    static var nextButtonStyler: NextButtonStylerProtocol?
    static public var navigationDelegate: VFEOnboardingNavigationProtocol?
    
    // MARK: - Public Variables
    
    private lazy var onboardingViewController: UIViewController = {
        let controller = OnboardingViewController(
            viewModel: OnboardingViewModel(data: data),
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil)
        controller.modalTransitionStyle = .crossDissolve
        controller.modalPresentationStyle = .fullScreen
        return controller
    }()
    
    // MARK: - Private Variables
    
    private let data: [VFEOnboardingModel]
    private var rootViewController: UIViewController?
    
    // MARK: - Public Initialization
    
    public init(data: [VFEOnboardingModel]) {
        self.data = data
    }
    
    // MARK: - Launch onboarding on top of presented view controller.
    
    public func launchOnboarding(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
        rootViewController.present(onboardingViewController, animated: true)
    }
    
    public func dismiss() {
        if rootViewController?.presentedViewController == onboardingViewController {
            onboardingViewController.dismiss(animated: true)
        }
    }
}
