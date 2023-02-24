//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Karl Pfister on 2/3/22.
//

import UIKit

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonMovesTableView.dataSource = self
        pokemonMovesTableView.delegate = self
        pokemonSearchBar.delegate = self
    }
    
    // MARK: - Properties
    var pokemon: Pokemon?
    
    // MARK: - Functions
    
    func updateViews(pokemon: Pokemon) {
        PokemonController.fetchImage(forPokemon: pokemon) { image in
            guard let image = image else {return}
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.pokemonSpriteImageView.image = image
                self.pokemonNameLabel.text = pokemon.name
                self.pokemonIDLabel.text = String(pokemon.id)
                self.pokemonMovesTableView.reloadData()
            }
        }
    }
    
} // End of class

// MARK: - extension

extension PokemonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokemon = pokemon else {return 0}
        return pokemon.moves.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        
        let moves = pokemon?.moves[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = moves
        cell.contentConfiguration = config
        
        return cell
    }
    
}

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        PokemonController.fetchPokemon(searhTerm: searchText) { pokemon in
            guard let pokemon = pokemon else {return}
            self.updateViews(pokemon: pokemon)
        }
    }
}
