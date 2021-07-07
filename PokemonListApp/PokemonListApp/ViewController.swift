    //
    //  ViewController.swift
    //  PokemonListApp
    //
    //  Created by Михаил Беленко on 11/08/2019.
    //  Copyright © 2019 Baltic Technology Company. All rights reserved.
    //
    
    import UIKit
    import Kingfisher
    import Foundation
    
    
    class ViewController: UIViewController, PokemonView, UITableViewDelegate, UITableViewDataSource {
        
        var presenter: ViewPresenter!
        var pokemonListTableView = UITableView()
        let identifire = "MyCell"
        
        var pokemonList: [Pokemon] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            presenter = Presenter(view: self, model: AppModel())
            createTable()
            presenter.loadData()
            _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ViewController.updateTable), userInfo: nil, repeats: true)
        }
        
        func createTable() {
            DispatchQueue.main.async {
                self.pokemonListTableView = UITableView(frame: self.view.bounds, style: .plain)
                self.pokemonListTableView.register(UITableViewCell.self, forCellReuseIdentifier: self.identifire)
                self.pokemonListTableView.delegate = self
                self.pokemonListTableView.dataSource = self
                
                
                self.view.addSubview(self.pokemonListTableView)
            }
        }
        
        @objc func updateTable() {
            
            DispatchQueue.main.async {
                self.pokemonListTableView.reloadData()
            }
        }
        
        func updatePokemonList(pokemonListInput: [Pokemon])
        {
            self.pokemonList.removeAll()
            for pokemon in pokemonListInput {
                self.pokemonList.append(pokemon)
            }
        }
        
        func updatePokemonList(pokemonInput: Pokemon)
        {
            self.pokemonList.append(pokemonInput)
        }
        
        // MARK: - UITableViewDataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.pokemonList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
            
            cell.textLabel?.text = "\(self.pokemonList[indexPath.row].name)"
            cell.imageView?.kf.setImage(with: URL.init(string: self.pokemonList[indexPath.row].urlSprite)!)
            cell.accessoryType = .disclosureIndicator
            
            if indexPath.row == self.pokemonList.count - 1 { // last cell
                presenter.loadData() // increment 'fromIndex' by 20 before server call
            }
            
            return cell
        }
        
        // MARK: - UITableViewDelegate
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100.0
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            presenter.openDetails(index: indexPath.row, navigationController: navigationController!)
        }
    }
