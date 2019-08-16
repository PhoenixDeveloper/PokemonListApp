    //
    //  ViewController.swift
    //  PokemonListApp
    //
    //  Created by Михаил Беленко on 11/08/2019.
    //  Copyright © 2019 Baltic Technology Company. All rights reserved.
    //
    
    import UIKit
    import Kingfisher
    
    
    class ViewController: UIViewController, PokemonView, UITableViewDelegate, UITableViewDataSource {
        
        var presenter: ViewPresenter!
        var pokemonListTableView = UITableView()
        let identifire = "MyCell"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            presenter = Presenter(view: self, model: AppModel())
            createTable()
            presenter.loadData()
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
            return presenter.countArray()
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
            
            cell.textLabel?.text = "\(presenter.getName(index: indexPath.row))"
            cell.imageView!.kf.setImage(with: presenter.getSpriteURL(index: indexPath.row)) { result in
                self.updateTable()
            }
            cell.accessoryType = .disclosureIndicator
            
            if indexPath.row == presenter.countArray() - 1 { // last cell
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
