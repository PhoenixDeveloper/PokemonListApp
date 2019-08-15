//
//  Router.swift
//  PokemonListApp
//
//  Created by Михаил Беленко on 15/08/2019.
//  Copyright © 2019 Baltic Technology Company. All rights reserved.
//

import UIKit

class Router: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = AppModel()
        let view = ViewController()
        let presenter = Presenter(view: view, model: model)
        view.presenter = presenter

        // Do any additional setup after loading the view.
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
