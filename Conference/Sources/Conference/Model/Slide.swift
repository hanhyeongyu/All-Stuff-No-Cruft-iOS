//
//  Slide.swift
//
//
//  Created by 한현규 on 8/23/24.
//

import Foundation



final class Slide: Identifiable, Decodable, Hashable{
    let id: Int
    let name: String
    let slideURL: URL        
    
    init(id: Int, name: String, slideURL: URL) {
        self.id = id
        self.name = name
        self.slideURL = slideURL
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Slide, rhs: Slide) -> Bool {
        lhs.id == rhs.id
    }
}
