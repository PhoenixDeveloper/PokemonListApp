    //
    //  ViewController.swift
    //  PokemonListApp
    //
    //  Created by Михаил Беленко on 11/08/2019.
    //  Copyright © 2019 Baltic Technology Company. All rights reserved.
    //
    
    import UIKit
    
    
    
    class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        var pokemonListTableView = UITableView()
        var offset = 0
        let identifire = "MyCell"
        var isDataLoading : Bool = false
        public static var selectedPokemonId : Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loadData()
        }
        
        func loadData() {
            if !isDataLoading{
                isDataLoading = true
                let urlString = "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=20"
                let url = URL.init(string: urlString)
                if offset != 980 { // more items to fetch
                    offset += 20
                }
                else {
                    isDataLoading = false
                    return
                }
                let task = URLSession.shared.dataTask(with: url!) {[weak self] (data, responce, error) in
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                            as! [String : AnyObject]
                        
                        if let bufferPokemonList = json["results"] as? NSMutableArray {
                            for pokemon in bufferPokemonList as! [NSMutableDictionary] {
                                let urlStringDetails = pokemon["url"] as! String
                                let urlDetails = URL.init(string: urlStringDetails)
                                do {
                                    let jsonDetails = try JSONSerialization.jsonObject(with: Data.init(contentsOf: urlDetails!), options: .mutableContainers) as! [String : AnyObject]
                                    
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
                                    
                                    AppModel.pokemonList.append(Pokemon(name: (pokemon["name"] as! String), urlSprite: urlSprite, weight: weight, id: id_pokemon))
                                    
                                    if ((AppModel.pokemonList.count) == ((self!.offset-20)+bufferPokemonList.count)) {
                                        if (self!.offset == 20) {
                                            self!.createTable()
                                            self!.isDataLoading = false
                                        }
                                        else {
                                            self!.updateTable()
                                            self!.isDataLoading = false
                                        }
                                    }
                                }
                                catch let jsonErrorDetails {
                                    print(jsonErrorDetails)
                                }
                            }
                        }
                    }
                    catch let jsonError {
                        print(jsonError)
                    }
                }
                task.resume()
            }
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
            return AppModel.pokemonList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
            
            cell.textLabel?.text = "\(AppModel.pokemonList[indexPath.row].name)"
            if let data = try? Data(contentsOf: URL(string: AppModel.pokemonList[indexPath.row].urlSprite)!)
            {
                cell.imageView?.image = UIImage(data: data)
            }
            cell.accessoryType = .disclosureIndicator
            
            if indexPath.row == AppModel.pokemonList.count - 1 { // last cell
                loadData() // increment 'fromIndex' by 20 before server call
            }
            
            return cell
        }
        
        // MARK: - UITableViewDelegate
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100.0
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            
            ViewController.selectedPokemonId = indexPath.row
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if ((pokemonListTableView.contentOffset.y + pokemonListTableView.frame.size.height) >= pokemonListTableView.contentSize.height)
            {
                loadData()
            }
        }
    }
