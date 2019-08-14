//
//  Pokemon.swift
//  PokemonListApp
//
//  Created by Михаил Беленко on 12/08/2019.
//  Copyright © 2019 Baltic Technology Company. All rights reserved.
//

import Foundation

class Pokemon {
    var name : String
    var urlSprite : String
    var weight : Int64
    var id_pokemon : Int
    
    init(name : String, urlSprite: String, weight: Int64, id: Int) {
        self.name = name
        self.urlSprite = urlSprite
        self.weight = weight
        self.id_pokemon = id
    }
}
