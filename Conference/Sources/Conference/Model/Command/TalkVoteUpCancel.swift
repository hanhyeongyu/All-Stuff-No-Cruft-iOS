//
//  Cancel.swift
//
//
//  Created by 한현규 on 9/9/24.
//

import Foundation
import Networks


struct TalkVoteUpCancel: APIRequest{
    typealias Output = Empty
    
    var endpoint: URL
    var method: HTTPMethod
    var query: QueryItems
    var header: HTTPHeader
    
    init(talkId: Int) {
        self.endpoint = BaseURL.talk.appendingPathComponent("/talks/vote/up")
        self.method = .delete
        self.query = ["talkId": talkId]
        self.header = [:]
    }
    
}
