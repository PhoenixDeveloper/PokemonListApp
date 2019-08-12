//
//  ViewController.swift
//  PokemonListApp
//
//  Created by Михаил Беленко on 11/08/2019.
//  Copyright © 2019 Baltic Technology Company. All rights reserved.
//

import UIKit

class Pokemon {
    var name : String
    var urlSprite : String
    
    init(name : String, urlSprite: String) {
        self.name = name
        self.urlSprite = urlSprite
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemonListTableView = UITableView()
    var offset = 0
    var pokemonList : [Pokemon] = []
    let identifire = "MyCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=20"
        let url = URL.init(string: urlString)
        
        let task = URLSession.shared.dataTask(with: url!) {[weak self] (data, responce, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    as! [String : AnyObject]
                
                if let bufferPokemonList = json["results"] as? NSMutableArray {
                    self?.pokemonList.removeAll()
                    for index in 0...19 {
                        let pokemon : NSMutableDictionary = bufferPokemonList[index] as! NSMutableDictionary
                        let urlStringDetails = pokemon["url"] as! String
                        let urlDetails = URL.init(string: urlStringDetails)
                        let taskDetail = URLSession.shared.dataTask(with: urlDetails!) { (dataDetails, responceDetails, errorDetails) in
                            do {
                                let jsonDetails = try JSONSerialization.jsonObject(with: dataDetails!, options: .mutableContainers)
                                    as! [String : AnyObject]
                                
                                var urlSprite : String = ""
                                
                                if let sprites = jsonDetails["sprites"] {
                                    urlSprite = sprites["back_default"] as! String
                                }
                                
                                self?.pokemonList.append(Pokemon(name: (pokemon["name"] as! String), urlSprite: urlSprite))
                                
                                if (index == 19) {
                                    self?.createTable()
                                }
                            }
                            catch let jsonErrorDetails {
                                print(jsonErrorDetails)
                            }
                        }
                        taskDetail.resume()
                    }
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
    }
    
    func createTable() {
        
        DispatchQueue.main.async {
        
        self.pokemonListTableView = UITableView(frame: self.view.bounds, style: .plain)
        self.pokemonListTableView.register(UITableViewCell.self, forCellReuseIdentifier: self.identifire)
        self.pokemonListTableView.delegate = self
        self.pokemonListTableView.dataSource = self
        
        self.pokemonListTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(self.pokemonListTableView)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        
        cell.textLabel?.text = "\(pokemonList[indexPath.row].name)"
        if let data = try? Data(contentsOf: URL(string: pokemonList[indexPath.row].urlSprite)!)
        {
            cell.imageView?.image = UIImage(data: data)
        }
        cell.accessoryType = .detailButton
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

