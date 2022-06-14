//
//  MainViewController.swift
//  Photo-Practice
//
//  Created by 소연 on 2022/06/14.
//

import UIKit

class MainViewController: UIViewController {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(touchUpPlusButton), for: .touchUpInside)
        return button
    }()
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubview(imageView)
        view.addSubview(plusButton)
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        plusButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80).isActive = true
        plusButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -80).isActive = true
        
        imageView.topAnchor.constraint(equalTo: self.plusButton.bottomAnchor, constant: 50).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    @objc func touchUpPlusButton() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "PhotoViewController") as? PhotoViewController else { return }
        present(vc, animated: true)
    }
}
