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
    var isDataLoading : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    func loadData() {
        let urlString = "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=20"
        let url = URL.init(string: urlString)
        
        let task = URLSession.shared.dataTask(with: url!) {[weak self] (data, responce, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    as! [String : AnyObject]
                
                let countLoad = (json["count"] as! Int - self!.pokemonList.count > 20) ? 20 : (json["count"] as! Int - self!.pokemonList.count)
                
                if let bufferPokemonList = json["results"] as? NSMutableArray {
                    for index in 0..<countLoad {
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
                                
                                if (index == countLoad-1 && self!.offset == 0) {
                                    self!.createTable()
                                }
                                else {
                                    self!.updateTable()
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
    
    func updateTable() {
        DispatchQueue.main.async {
            self.pokemonListTableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        
        cell.textLabel?.text = "\(pokemonList[indexPath.row].name)"
        if let data = try? Data(contentsOf: URL(string: pokemonList[indexPath.row].urlSprite)!)
        {
            cell.imageView?.image = UIImage(data: data)
        }
        cell.accessoryType = .detailButton
        
        if indexPath.row == pokemonList.count - 1 { // last cell
            if offset != 960 { // more items to fetch
                offset += 20
                loadData() // increment 'fromIndex' by 20 before server call
            }
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDataLoading = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((pokemonListTableView.contentOffset.y + pokemonListTableView.frame.size.height) >= pokemonListTableView.contentSize.height)
        {
            if !isDataLoading{
                isDataLoading = true
                loadData()
            }
        }
    }
}

