//
//  Talk.swift
//  
//
//  Created by 한현규 on 8/23/24.
//

import Foundation
import SwiftUI
import Networks


final class Talk: Identifiable, Hashable, Decodable{

    let id: Int
    let conferenceId: Int
    let name: String
    let description: String
    let speaker: Speaker
    
    
    init(id: Int, conferenceId: Int, name: String, description: String, speaker: Speaker) {
        self.id = id
        self.conferenceId = conferenceId
        self.name = name
        self.description = description
        self.speaker = speaker
    }
    
    var slides:  [Slide]{
        get async throws{
            let request = GetSlides(talkId: self.id)
            let response = try await AUTHAPI.send(request)            
            return response
        }
    }
    
    var talkVideos: [TalkVideo]{
        get async throws{
            let request = GetTalkVideos(talkId: self.id)
            let response = try await AUTHAPI.send(request)
            return response
        }
    }

    var reaction: Reaction{
        get async throws{
            let query = GetTalkReaction(talkId: self.id)
            let result = try await AUTHAPI.send(query)
            return result
        }
    }        
    
    func up() async throws{
        let command = TalkVoteUp(talkId: self.id)
        _ = try await AUTHAPI.send(command)
    }
    
    func cancelUp() async throws{
        let command = TalkVoteUpCancel(talkId: self.id)
        _ = try await AUTHAPI.send(command)
    }
    
    func down() async throws{
        let command = TalkVoteDown(talkId: self.id)
        _ = try await AUTHAPI.send(command)
    }
    
    func cancelDown() async throws{
        let command = TalkVoteDownCancel(talkId: self.id)
        _ = try await AUTHAPI.send(command)
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
    static func == (lhs: Talk, rhs: Talk) -> Bool {
        lhs.id == rhs.id
    }
}
