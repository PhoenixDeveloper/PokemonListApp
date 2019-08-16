//
//  TestViewController.swift
//  PokemonListApp
//
//  Created by Михаил Беленко on 16/08/2019.
//  Copyright © 2019 Baltic Technology Company. All rights reserved.
//

import UIKit
import Kingfisher

class TestViewController: UIViewController {
    
    let imageView = UIImageView(frame: CGRect(x: 20, y: 100, width: 375, height: 300))
    let labelNameTitle = UILabel(frame: CGRect(x: 20, y: 420, width: 150, height: 60))
    let labelNameView = UILabel(frame: CGRect(x: 80, y: 485, width: 255, height: 60))
    let labelWeightTitle = UILabel(frame: CGRect(x: 20, y: 550, width: 170, height: 60))
    let labelWeightView = UILabel(frame: CGRect(x: 70, y: 620, width: 280, height: 60))
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelWeightView.translatesAutoresizingMaskIntoConstraints = false
        labelWeightTitle.translatesAutoresizingMaskIntoConstraints = false
        labelNameView.translatesAutoresizingMaskIntoConstraints = false
        labelNameTitle.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.kf.setImage(with: URL(string: "https://doc.louisiana.gov/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png")!)
        
        view.addSubview(imageView)
        
        labelNameTitle.text = "Name"
        labelNameTitle.font = UIFont(name: "Helvetica Neue", size: 50)
        view.addSubview(labelNameTitle)
        
        labelNameView.text = "XXX"
        labelNameView.font = UIFont(name: "Helvetica Neue", size: 50)
        view.addSubview(labelNameView)
        
        labelWeightTitle.text = "Weight"
        labelWeightTitle.font = UIFont(name: "Helvetica Neue", size: 50)
        view.addSubview(labelWeightTitle)
        
        labelWeightView.text = "XXX"
        labelWeightView.font = UIFont(name: "Helvetica Neue", size: 50)
        view.addSubview(labelWeightView)
        
        createImageViewConstraints()
        createLabelNameTitleConstraints()
        createLabelNameViewConstraints()
        createLabelWeightTitleConstraints()
        createLabelWeightViewConstraints()

        // Do any additional setup after loading the view.
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
