//
//  Protocols.swift
//  PokemonListApp
//
//  Created by Михаил Беленко on 15/08/2019.
//  Copyright © 2019 Baltic Technology Company. All rights reserved.
//

import Foundation
import UIKit

protocol PokemonView: class {
    func createTable()
    func updateTable()
}

protocol ViewPresenter {
    init(view: PokemonView, model: AppModel)
    func loadData()
    func openDetails(index: Int, storyboard: UIStoryboard, navigationController: UINavigationController)
    func loadDetails(view: DetailsViewController)
    func countArray() -> Int
    func getName(index: Int) -> String
    func getWeight(index: Int) -> Int64
    func getSpriteURL(index: Int) -> URL
    func getPokemonId(index: Int) -> Int
}
