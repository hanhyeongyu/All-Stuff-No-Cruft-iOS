//
//  Conference.swift
//
//
//  Created by 한현규 on 8/23/24.
//

import Foundation
import Networks


@Observable
final class Conference: Identifiable, Hashable, Decodable{

    let id: Int
    let name: String
    let information: Information
    let address: Address
    let schedule: Schedule
    let capacity: Capacity
    let price: Price
    let posterURL: String?
    
    init(id: Int, name: String, information: Information, address: Address, schedule: Schedule, capacity: Capacity, price: Price, posterURL: String?) {
        self.id = id
        self.name = name
        self.information = information
        self.address = address
        self.schedule = schedule
        self.capacity = capacity
        self.price = price
        self.posterURL = posterURL
    }
      
    
    var poster: URL?{
        guard let posterURL = posterURL else { return nil }
        return URL(string: posterURL)        
    }
    
    var talks: [Talk]{
        get async throws{
            let request = GetTalks(conferenceId: self.id)
            let response = try await API.send(request, sessionType: .Api)
            return response
        }
    }
            
    static func conferences(continuationToken: String?) async throws -> Page<Conference>{
        let request = GetConferences(continuationToken: continuationToken)
        let response =  try await API.send(request, sessionType: .Api)
        return response
    }
    
    static func joinedConference(continuationToken: String?) async throws -> Page<Conference>{
        let request = GetJoinedConferences(continuationToken: continuationToken)
        let response = try await AUTHAPI.send(request)
        return response
    }
    
    
    func join() async throws{
        let request = JoinConference(confernceId: self.id)
        _ = try await AUTHAPI.send(request)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Conference, rhs: Conference) -> Bool {
        lhs.id == rhs.id
    }
              
}
