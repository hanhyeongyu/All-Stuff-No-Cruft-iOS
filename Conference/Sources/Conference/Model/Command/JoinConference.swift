//
//  JoinConference.swift
//
//
//  Created by 한현규 on 9/2/24.
//

import Foundation
import Networks


struct JoinConference: APIRequest{
    typealias Output = Empty
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(confernceId: Int) {
        self.endpoint = BaseURL.conference.appendingPathComponent("conferences/join")
        self.method = .post
        self.query = ["conferenceId": confernceId]
        self.header = [:]
    }        
}
