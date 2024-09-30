//
//  BaseURL+Conference.swift
//
//
//  Created by 한현규 on 8/28/24.
//

import Foundation
import Networks


extension BaseURL{
    static var conference: URL{
        URL(string: "http://localhost:8080")!
    }
    
    static var talk: URL{
        URL(string: "http://localhost:8080")!
    }
}
