//
//  GetConferences.swift
//
//
//  Created by 한현규 on 8/28/24.
//

import Foundation
import Networks


struct GetConferences: APIRequest{
    typealias Output = Page<Conference>
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(continuationToken: String?) {
        self.endpoint = BaseURL.conference.appendingPathComponent("/conferences")
        self.method = .get
        self.query = continuationToken == nil ? [:] : ["continuationToken": continuationToken]
        self.header = [:]
    }    
}
