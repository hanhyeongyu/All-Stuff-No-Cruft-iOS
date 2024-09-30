//
//  Speaker.swift
//
//
//  Created by 한현규 on 8/23/24.
//

import Foundation
import SwiftUI


final class Speaker: Identifiable, Hashable, Decodable{
    let id: Int
    let name: String
    let introduce: String
    let imageURL: String?
    
    var profile: URL?{
        guard let imageURL = imageURL else { return nil}     
        return URL(string: imageURL)
    }
    
    init(id: Int, name: String, introduce: String, profileImageURL: String?) {
        self.id = id
        self.name = name
        self.introduce = introduce
        self.imageURL = profileImageURL
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Speaker, rhs: Speaker) -> Bool {
        lhs.id == rhs.id
    }
}

    
    
