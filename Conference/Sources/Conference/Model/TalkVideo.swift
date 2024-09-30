//
//  TalkVideo.swift
//
//
//  Created by 한현규 on 9/8/24.
//

import Foundation


struct TalkVideo: Identifiable, Decodable, Hashable{
    let id: Int
    let name: String
    let videoURL: URL
    
    init(id: Int, name: String, videoURL: URL) {
        self.id = id
        self.name = name
        self.videoURL = videoURL
    }
    
}
