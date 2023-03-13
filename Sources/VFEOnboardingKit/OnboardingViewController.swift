//
//  OnboardingViewController.swift
//  
//
//  Created by Hassan Ashraf on 04/03/2023.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    
    // MARK: - UI Views
    
    private lazy var nextButton: NextButtonView = NextButtonView()
    
    private lazy var pageControl: VFEPageControl = {
        let pageControl = VFEPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.dotSize = 10
        pageControl.dotColor = .darkGray
        pageControl.selectedColor = .red
        return pageControl
    }()
    
    private lazy var skipButton: SkipButtonView = SkipButtonView()
    
    // MARK: - Variables
    
    private var viewModel: OnboardingViewModelProtocol
    private lazy var pages: [UIViewController] = []
    
    // MARK: - Initialization
    
    init(
        viewModel: OnboardingViewModelProtocol,
        transitionStyle: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey : Any]? = nil
    ) {
        self.viewModel = viewModel
        super.init(
            transitionStyle: transitionStyle,
            navigationOrientation: navigationOrientation,
            options: options
        )
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPageViewController()
        setupPageControl()
    }
    
    // MARK: - Actions
    
    @objc private func didPressNextButton() {
        guard viewModel.shouldNavigateToNextPage() else {
            viewModel.didReachLastPage()
            return
        }
        self.setViewControllers(
            [pages[viewModel.currentPageIndex + 1]],
            direction: .forward,
            animated: true,
            completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.viewModel.updateCurrent(index: strongSelf.viewModel.currentPageIndex + 1)
            strongSelf.updatePageControlSelectedIndex()
        }
    }
    
    @objc private func didPressSkipButton(_ sender: UIButton) {
        viewModel.didPressSkipButton()
    }
    
    // MARK: - Setup UIPageViewController
    
    private func setupPageViewController() {
        delegate = self
        dataSource = self
        viewModel.generatePageViewModels().forEach { model in
            let pageViewController = PageViewController(viewModel: model)
            pages.append(pageViewController)
        }
        setViewControllers(
            [pages[viewModel.initialPageIndex]],
            direction: .forward,
            animated: true,
            completion: nil
        )
    }
    
    // MARK: - Setup PageControl
    
    func setupPageControl() {
        pageControl.pages = pages.count
    }
   
}

// MARK: - Setup Views & Auto Layout

extension OnboardingViewController {
    
    private func setupViews() {
        view.backgroundColor = .white
        setupSkipButtonView()
        setupNextButtonView()
        setupPageControlView()
    }
    
    private func setupSkipButtonView() {
        view.addSubview(skipButton)
        skipButton.addTarget(self, action: #selector(didPressSkipButton(_:)), for: .touchUpInside)
        skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
    }
    
    private func setupNextButtonView() {
        nextButton.setTitle(viewModel.getActionButtonTitle(), for: .normal)
        view.addSubview(nextButton)
        nextButton.onButtonPressed = didPressNextButton
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupPageControlView() {
        view.addSubview(pageControl)
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        pageControl.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
    }
    
    private func updatePageControlSelectedIndex() {
        pageControl.selectedPage = viewModel.currentPageIndex
        nextButton.setTitle(viewModel.getActionButtonTitle(), for: .normal)
        skipButton.setTitle(viewModel.getSkipButtonTitle(), for: .normal)
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return viewModel.shouldNavigateToPreviousPage() ? pages[viewModel.currentPageIndex - 1] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return viewModel.shouldNavigateToNextPage() ? pages[viewModel.currentPageIndex + 1] : nil
    }
}

// MARK: UIPageViewControllerDelegate

extension OnboardingViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        viewModel.updateCurrent(index: currentIndex)
        updatePageControlSelectedIndex()
    }
    
}


// MARK: - Testing Variables

extension OnboardingViewController {
    var testNextButton: NextButtonView { return nextButton }
    var testSkipButton: SkipButtonView { return skipButton }
    var testPageControl: VFEPageControl { return pageControl }
    var testPages: [UIViewController] { return pages }
}
