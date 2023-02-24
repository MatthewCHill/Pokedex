//
//  Pokemon.swift
//  Pokedex
//
//  Created by Matthew Hill on 2/23/23.
//

import Foundation

class Pokemon {
    
    let name: String
    let id: Int
    let moves: [String]
    let spritePath: String
    
    enum Keys: String {
        case name
        case id
        case moves
        case move
        case sprites
       case spritePath = "front_shiny"
    }
    
        init?(dict: [String: Any]) {
        
        guard let name = dict[Keys.name.rawValue] as? String,
              let id = dict[Keys.id.rawValue] as? Int,
              let spriteDict = dict[Keys.sprites.rawValue] as? [String : Any],
              let spritePath = spriteDict[Keys.spritePath.rawValue] as? String,
              let movesArray = dict[Keys.moves.rawValue] as? [[String : Any]]
            else {return nil}
            
        var moves: [String] = []
        
        for dict in movesArray {
            guard let moveDict = dict[Keys.move.rawValue] as? [String : Any],
                  let moveName = moveDict[Keys.name.rawValue] as? String else { return nil}
            moves.append(moveName)
        }
            self.name = name
            self.id = id
            self.moves = moves
            self.spritePath = spritePath
        
    }
}
