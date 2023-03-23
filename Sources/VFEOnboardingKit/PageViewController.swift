//
//  PageViewController.swift
//  
//
//  Created by Hassan Ashraf on 03/03/2023.
//

import UIKit

class PageViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
//        view.backgroundColor = .red
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 8
        return view
    }()
    
    // MARK: Initialization
    
    init(viewModel: PageViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = viewModel.image
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {

        view.addSubview(imageView)
        view.addSubview(stackView)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 36).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.60).isActive = true
        
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
    }
    
}

extension PageViewController {
    var testTitleLabel: UILabel { return self.titleLabel }
    var testSubtitleLabel: UILabel { return self.subtitleLabel }
    var testStackView: UIStackView { return self.stackView }
}
