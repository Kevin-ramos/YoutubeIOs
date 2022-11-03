//
//  BaseViewController.swift
//  Youtube
//
//  Created by user228543 on 10/13/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func configNavigationBar(){
        let stackOptions = UIStackView()
        stackOptions.axis = .horizontal
        stackOptions.distribution = .fillEqually
        stackOptions.spacing = 0.0
        stackOptions.translatesAutoresizingMaskIntoConstraints = false
        
        //crear botones
        let share = buildButtons(selector: #selector(shareButtonPressed), image: UIImage(named: "cast")!, inset: 30)
        let magnify = buildButtons(selector: #selector(magnifyButtonPressed), image: UIImage(named: "magnifying")!, inset: 30)
        let dots = buildButtons(selector: #selector(dotsButtonPressed), image: UIImage(named: "dots")!, inset: 33)
        
        stackOptions.addArrangedSubview(share)
        stackOptions.addArrangedSubview(magnify)
        stackOptions.addArrangedSubview(dots)
        
        stackOptions.widthAnchor.constraint(equalToConstant: 120).isActive = true
        let customItemView = UIBarButtonItem(customView: stackOptions)
        customItemView.tintColor = .clear
        navigationItem.rightBarButtonItem = customItemView
        
    }
    
    private func buildButtons(selector: Selector, image : UIImage, inset : CGFloat) -> UIButton{
        let button = UIButton(type: .custom)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor(named: "whiteColor")
        let extraPadding : CGFloat = 2.0
        button.imageEdgeInsets = UIEdgeInsets(top: inset+extraPadding, left: inset, bottom: inset+extraPadding, right: inset)
        return button
    }
    
    
    
    @objc func shareButtonPressed(){
        print("ShareButtonPressed")
    }
    
    @objc func magnifyButtonPressed(){
        print("magnifyButtonPressed")
    }
    
    @objc func dotsButtonPressed(){
       
    }

}
