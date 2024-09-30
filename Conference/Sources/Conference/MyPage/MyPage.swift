//
//  ScheduleHome.swift
//
//
//  Created by 한현규 on 9/2/24.
//

import SwiftUI


public struct MyPage: View {
    
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
                Section(
                    content: {
                        ScrollView(.horizontal, showsIndicators: false){
                            LazyHStack(spacing: 16.0){
                                ForEach(conferences){ conference in
                                    JoinedConferenceRow(conference: conference)
                                        .onTapGesture {
                                            path.append(conference)
                                        }
                                }
                            }
                            .padding()
                        }
                        .aspectRatio(3 / 1, contentMode: .fit)
                        .listRowInsets(.init())
                        .listRowSeparator(.hidden)
                        .listRowBackground(EmptyView())
                    },
                    header: {
                        Text("Joined Conference")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                )
                .foregroundStyle(.primary)
            }
            .listStyle(.plain)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Conference.self) { conference in
                JoinedConference(conference: conference, path: $path)
            }
            .task {
                do{
                    if isLast(){
                        return
                    }
                                
                    let page = try await Conference.joinedConference(continuationToken: continuationToken)
                    self.conferences.append(contentsOf: page.items)
                    self.continuationToken = page.continuationToken
                }catch{
                    print(error)
                }
            }
        }
    }
    
    private func isLast() -> Bool{
        !conferences.isEmpty && continuationToken == nil
    }
}

#Preview {
    MyPage()
}
