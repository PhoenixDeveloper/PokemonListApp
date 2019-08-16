//
//  DetailsViewController.swift
//  PokemonListApp
//
//  Created by Михаил Беленко on 12/08/2019.
//  Copyright © 2019 Baltic Technology Company. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    let imageView = UIImageView(frame: CGRect(x: 20, y: 100, width: 375, height: 300))
    let labelNameTitle = UILabel(frame: CGRect(x: 20, y: 420, width: 150, height: 60))
    let labelNameView = UILabel(frame: CGRect(x: 80, y: 485, width: 255, height: 60))
    let labelWeightTitle = UILabel(frame: CGRect(x: 20, y: 550, width: 170, height: 60))
    let labelWeightView = UILabel(frame: CGRect(x: 70, y: 620, width: 280, height: 60))
    
    var presenter: ViewPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelWeightView.translatesAutoresizingMaskIntoConstraints = false
        labelWeightTitle.translatesAutoresizingMaskIntoConstraints = false
        labelNameView.translatesAutoresizingMaskIntoConstraints = false
        labelNameTitle.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        
        labelNameTitle.text = "Name"
        labelNameTitle.font = UIFont(name: "Helvetica Neue", size: 50)
        view.addSubview(labelNameTitle)
        
        labelNameView.font = UIFont(name: "Helvetica Neue", size: 50)
        view.addSubview(labelNameView)
        
        labelWeightTitle.text = "Weight"
        labelWeightTitle.font = UIFont(name: "Helvetica Neue", size: 50)
        view.addSubview(labelWeightTitle)
        
        labelWeightView.font = UIFont(name: "Helvetica Neue", size: 50)
        view.addSubview(labelWeightView)
        
        createImageViewConstraints()
        createLabelNameTitleConstraints()
        createLabelNameViewConstraints()
        createLabelWeightTitleConstraints()
        createLabelWeightViewConstraints()

        //presenter.loadDetails(view: self)
    }
    
    
    
    func viewData(name: String, weight: Int64, url: URL) {
        labelNameView.text = name
        labelWeightView.text = "\(weight)"
        imageView.kf.setImage(with: url)
    }
    
    func initPresenter(presenter: ViewPresenter)
    {
        self.presenter = presenter
    }
    
    func createImageViewConstraints() {
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: labelNameTitle.topAnchor, constant: 7.5).isActive = true
    }
    
    func createLabelNameTitleConstraints() {
        labelNameTitle.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        labelNameTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        labelNameTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 7.5).isActive = true
        labelNameTitle.bottomAnchor.constraint(equalTo: labelNameView.topAnchor, constant: 7.5).isActive = true
    }
    
    func createLabelNameViewConstraints() {
        labelNameView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelNameView.topAnchor.constraint(equalTo: labelNameTitle.bottomAnchor, constant: 7.5).isActive = true
        labelNameView.bottomAnchor.constraint(equalTo: labelWeightTitle.topAnchor, constant: 7.5).isActive = true
    }
    
    func createLabelWeightTitleConstraints() {
        labelWeightTitle.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        labelWeightTitle.topAnchor.constraint(equalTo: labelNameView.bottomAnchor, constant: 7.5).isActive = true
        labelWeightTitle.bottomAnchor.constraint(equalTo: labelWeightView.topAnchor, constant: 7.5).isActive = true
    }
    
    func createLabelWeightViewConstraints() {
        labelWeightView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelWeightView.topAnchor.constraint(equalTo: labelWeightTitle.bottomAnchor, constant: 7.5).isActive = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
