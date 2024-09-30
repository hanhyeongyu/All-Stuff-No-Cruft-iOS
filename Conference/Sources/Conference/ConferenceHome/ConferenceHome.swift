//
//  ConferenceHome.swift
//
//
//  Created by 한현규 on 8/23/24.
//

import SwiftUI

public struct ConferenceHome: View {
    
    @State
    private var conferences: [Conference]
    
    @State
    private var path: NavigationPath
        
    @State
    private var continuationToken: String?
    
    public init() {
        self.conferences = []
        self.path = .init()
    }
    
    public var body: some View {
        NavigationStack(path: $path) {                        
            List {
                ForEach(conferences){ conference in
                    ConferenceCard(conference: conference)
                        .aspectRatio(3 / 2, contentMode: .fit)
                        .onTapGesture {
                            path.append(conference)
                        }
                }
                .listRowInsets(.init())
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .task {
                do{
                    if isLast(){
                        return
                    }                    
                    
                    let page = try await Conference.conferences(continuationToken: continuationToken)
                    self.conferences.append(contentsOf: page.items)
                    self.continuationToken = page.continuationToken
                }catch{
                    print(error)
                }
            }
            .navigationTitle("Conferences")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: Conference.self) { conference in
                ConferenceView(conference: conference, path: $path)
            }
        }
    }
    
    private func isLast() -> Bool{
        !conferences.isEmpty && continuationToken == nil
    }
}

#Preview {
    ConferenceHome()
}
