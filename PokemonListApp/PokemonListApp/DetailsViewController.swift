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

    @IBOutlet weak public var imageView: UIImageView!
    @IBOutlet weak public var labelNameView: UILabel!
    @IBOutlet weak public var labelWeightView: UILabel!
    
    var presenter: ViewPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.loadDetails(view: self)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
