//
//  PokemonController.swift
//  Pokedex
//
//  Created by Matthew Hill on 2/23/23.
//

import UIKit

class PokemonController {
    
    static func fetchPokemon(searhTerm: String, completion: @escaping (Pokemon?) -> Void) {
        // I want to get the final url
        guard let baseURL = URL(string: Constants.PokemonURL.baseURL) else {completion(nil) ; return}
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(contentsOf: searhTerm)
        
        guard let finalURL = urlComponents?.url else {completion(nil); return}
        print(finalURL)
        
        // Fetch Data with URL
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard let data = data else { completion(nil); return}
            
            do {
                if let topLevelDictionary = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any] {
                    
                    let pokemon = Pokemon(dict: topLevelDictionary)
                    completion(pokemon)
                }
            } catch {
                print(error.localizedDescription)
                completion(nil)
                return
            }
        } .resume()
        
    }
    
    static func fetchImage(searchTerm: String, completion: @escaping (UIImage?) -> Void) {
        guard let baseURL = URL(string: Constants.PokemonURL.baseURL) else { completion(nil) ; return}
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(contentsOf: searchTerm)
        
        guard let finalURL = urlComponents?.url else { completion(nil) ; return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { data, _ , error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data else { completion(nil) ; return}
            
            let pokemonImage = UIImage(data: data)
            completion(pokemonImage)
        } .resume()
    }
}
