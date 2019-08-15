//
//  Presenter.swift
//  PokemonListApp
//
//  Created by Михаил Беленко on 15/08/2019.
//  Copyright © 2019 Baltic Technology Company. All rights reserved.
//

import UIKit
import Alamofire

class Presenter: ViewPresenter {
    
    unowned let view: PokemonView
    var model : AppModel

    var offset = 0
    var isDataLoading : Bool = false
    var maxCount : Int = 1000
    
    required init(view: PokemonView, model: AppModel) {
        self.view = view
        self.model = model
    }
    
    func countArray() -> Int {
        return model.pokemonList.count
    }
    
    func getName(index: Int) -> String {
        return model.pokemonList[index].name
    }
    
    func getWeight(index: Int) -> Int64 {
        return model.pokemonList[index].weight
    }
    
    func getSpriteURL(index: Int) -> URL {
        return URL.init(string: model.pokemonList[index].urlSprite)!
    }
    
    func getPokemonId(index: Int) -> Int {
        return model.pokemonList[index].id_pokemon
    }
    
    func openDetails(index: Int, storyboard: UIStoryboard, navigationController: UINavigationController) {
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        vc.viewData(name: model.pokemonList[index].name, weight: model.pokemonList[index].weight, url: URL.init(string: model.pokemonList[index].urlSprite)!)
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func loadData() {
        if !isDataLoading{
            isDataLoading = true
            let urlString = "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=20"
            guard let url = URL.init(string: urlString) else {
                print("Не удалось создать URL")
                isDataLoading = false
                return
            }
            if offset != (maxCount-(maxCount % 20)+20) { // more items to fetch
                offset += 20
            }
            else {
                isDataLoading = false
                return
            }
            
            Alamofire.request(url).responseJSON { [weak self] response in
                guard response.result.isSuccess else {
                    print("Ошибка при запросе данных\(String(describing: response.result.error))")
                    self!.isDataLoading = false
                    return
                }
                
                guard let json = response.result.value as? [String : AnyObject]
                    else {
                        print("Не могу перевести в JSON")
                        self!.isDataLoading = false
                        return
                }
                
                guard let bufferPokemonList = json["results"] as? [NSDictionary]
                    else {
                        print("Невозможно создать список покемонов")
                        self!.isDataLoading = false
                        return
                }
                
                if let count = json["count"] as? Int
                {
                    self!.maxCount = count
                }
                
                for pokemon in bufferPokemonList {
                    let urlStringDetails = pokemon["url"] as! String
                    guard let urlDetails = URL.init(string: urlStringDetails) else {
                        print("Не удалось создать URL покемона")
                        self!.isDataLoading = false
                        return
                    }
                    Alamofire.request(urlDetails).responseJSON { responseDetails in
                        guard responseDetails.result.isSuccess else {
                            print("Ошибка при запросе данных\(String(describing: responseDetails.result.error))")
                            self!.isDataLoading = false
                            return
                        }
                        
                        guard let jsonDetails = responseDetails.result.value as? [String : AnyObject]
                            else {
                                print("Не могу перевести в JSON")
                                self!.isDataLoading = false
                                return
                        }
                        
                        var urlSprite : String = ""
                        var id_pokemon = 0
                        let weight : Int64 = jsonDetails["weight"] as! Int64
                        
                        if let sprites = jsonDetails["sprites"] {
                            if (sprites["front_default"] is NSNull)
                            {
                                if (sprites["back_default"] is NSNull) {
                                    urlSprite = "https://doc.louisiana.gov/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png"
                                }
                                else {
                                    urlSprite = sprites["back_default"] as! String
                                }
                            }
                            else
                            {
                                urlSprite = sprites["front_default"] as! String
                            }
                        }
                        
                        id_pokemon = jsonDetails["id"] as! Int
                        
                        self!.model.pokemonList.append(Pokemon(name: (pokemon["name"] as! String), urlSprite: urlSprite, weight: weight, id: id_pokemon))
                        
                        // Debug-инструмент для отслеживания загрузки покемонов
                        print("\(self!.model.pokemonList.count) / \((self!.offset-20)+bufferPokemonList.count)")
                        
                        if ((self!.model.pokemonList.count) == ((self!.offset-20)+bufferPokemonList.count)) {
                            self!.view.updateTable()
                            self!.isDataLoading = false
                        }
                        
                    }
                }
            }
        }
    }
    
    
}
