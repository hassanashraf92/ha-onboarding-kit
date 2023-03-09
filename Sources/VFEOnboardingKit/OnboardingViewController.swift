//
//  OnboardingViewController.swift
//  
//
//  Created by Hassan Ashraf on 04/03/2023.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    
    // MARK: - UI Views
    private lazy var nextButton: UIButton = NextButtonView()//{
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.cornerRadius = 25//button.frame.width / 2
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        button.setTitle(viewModel.nextButtonTitle, for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = .red
//        button.addTarget(self, action: #selector(didPressNextButton(_:)), for: .touchUpInside)
//        return button
//    }()
    
    private lazy var pageControl: VFEPageControl = {
        let pageControl = VFEPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.dotSize = 10
        pageControl.dotColor = .darkGray
        pageControl.selectedColor = .red
        return pageControl
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didPressSkipButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Variables
    private var viewModel: OnboardingViewModelProtocol
    private let initialPageIndex: Int = 0
    private var pages: [UIViewController] = []
    
    var currentIndex: Int {
        guard let vc = viewControllers?.first else { return 0 }
        return pages.firstIndex(of: vc) ?? 0
    }
    
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
    
    @objc func didPressNextButton(_ sender: UIButton) {
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
//        viewModel.didPressNextButton()
    }
    
    @objc func didPressSkipButton(_ sender: UIButton) {
        viewModel.didPressSkipButton()
    }
    
    // MARK: - Setup UIPageViewController
    
    func setupPageViewController() {
        delegate = self
        dataSource = self
        viewModel.generatePageViewModels().forEach { model in
            let pageViewController = PageViewController(viewModel: model)
            pages.append(pageViewController)
        }
        setViewControllers(
            [pages[initialPageIndex]],
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
//        setupNextButtonStyling()
        setupPageControlView()
    }
    
//    private func setupNextButtonStyling() {
//        let styler = NextButtonStyler()
//        nextButton.layer.cornerRadius = styler.style.cornerRadius
//        nextButton.backgroundColor = styler.style.backgroundColor
//        nextButton.setTitleColor(styler.style.foregroundColor, for: .normal)
//        nextButton.layer.borderWidth = styler.style.borderWidth ?? 0
//        nextButton.layer.borderColor = styler.style.borderColor?.cgColor
//    }
    
    private func setupSkipButtonView() {
        view.addSubview(skipButton)
        skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
    }
    
    private func setupNextButtonView() {
        nextButton.setTitle(viewModel.nextButtonTitle, for: .normal)
        view.addSubview(nextButton)
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
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
//        viewModel.updateCurrent(index: viewControllerIndex)
        return viewModel.shouldNavigateToPreviousPage() ? pages[viewModel.currentPageIndex - 1] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
//        viewModel.updateCurrent(index: viewControllerIndex)
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
    
//    func isOnLastPage() -> Bool {
//        guard let pageViewController = self.pageViewController else {
//            return false
//        }
//
//        let currentPageIndex = self.presentationIndex(for: pageViewController)
//        let totalPages = pages.count
//
//        return currentPageIndex == totalPages - 1
//    }
}


// MARK: - Testing Variables

extension OnboardingViewController {
    var testNextButton: UIButton { return nextButton }
    var testSkipButton: UIButton { return skipButton }
    var testPageControl: VFEPageControl { return pageControl }
    var testPages: [UIViewController] { return pages }
}
