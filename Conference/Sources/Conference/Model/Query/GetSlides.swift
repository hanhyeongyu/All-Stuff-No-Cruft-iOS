//
//  GetSlides.swift
//
//
//  Created by 한현규 on 9/5/24.
//

import Foundation
import Networks


struct GetSlides: APIRequest{
    typealias Output = [Slide]
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(talkId: Int) {
        self.endpoint = BaseURL.talk.appendingPathComponent("/slides")
        self.method = .get
        self.query = ["talkId": talkId]
        self.header = [:]
    }        
}


