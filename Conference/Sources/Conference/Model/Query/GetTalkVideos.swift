//
//  File.swift
//  
//
//  Created by 한현규 on 9/8/24.
//

import Foundation
import Networks


struct GetTalkVideos: APIRequest{
    typealias Output = [TalkVideo]
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    
    init(talkId: Int) {
        self.endpoint = BaseURL.talk.appendingPathComponent("/talkVideos")
        self.method = .get
        self.query = ["talkId": talkId]
        self.header = [:]
    }        
}
