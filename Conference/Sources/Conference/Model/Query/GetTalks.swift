//
//  GetTalks.swift
//
//
//  Created by 한현규 on 8/30/24.
//

import Foundation
import Networks


struct GetTalks: APIRequest{
    typealias Output = [Talk]
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(conferenceId: Int) {
        self.endpoint = BaseURL.talk.appendingPathComponent("/talks")
        self.method = .get
        self.query = ["conferenceId": conferenceId]
        self.header = [:]
    }        
}
