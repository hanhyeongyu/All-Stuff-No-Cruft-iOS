//
//  Reaction.swift
//
//
//  Created by 한현규 on 9/9/24.
//

import Foundation

struct Reaction: Decodable{
    let targetId: Int
    let up: Int
    let down: Int
    let reactionType: ReactionType?
    
    
    enum ReactionType: String, Decodable{
        case UP
        case DOWN
    }
}
