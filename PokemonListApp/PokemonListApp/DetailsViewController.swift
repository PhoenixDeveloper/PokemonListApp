//
//  DetailsViewController.swift
//  PokemonListApp
//
//  Created by Михаил Беленко on 12/08/2019.
//  Copyright © 2019 Baltic Technology Company. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak public var imageView: UIImageView!
    @IBOutlet weak public var labelNameView: UILabel!
    @IBOutlet weak public var labelWeightView: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        labelNameView.text = AppModel.pokemonList[ViewController.selectedPokemonId].name
        labelWeightView.text = "\(AppModel.pokemonList[ViewController.selectedPokemonId].weight)"
        if let data = try? Data(contentsOf: URL(string: AppModel.pokemonList[ViewController.selectedPokemonId].urlSprite)!)
        {
            imageView.image = UIImage(data: data)
        }
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
