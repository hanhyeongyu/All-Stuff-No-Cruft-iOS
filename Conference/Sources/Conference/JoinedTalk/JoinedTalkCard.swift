//
//  JoinedTalkCard.swift
//
//
//  Created by 한현규 on 9/2/24.
//

import SwiftUI
import UIUtil


struct JoinedTalkCard: View {
    
    private let talk: Talk
    
    @State
    private var reaction: Reaction?
    
    init(talk: Talk) {
        self.talk = talk
        self.reaction = nil
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top){
                VStack{
                    CircleImage(url: talk.speaker.profile)
                        .frame(width: 50.0, height: 50.0)
                    
                    Text(talk.speaker.name)
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(.background)
                }
                
                Spacer()
                                
                Text("Live")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 8.0)
                    .background(Color.red)
                    .clipShape(.capsule)
            }
            
            Text(talk.description)
                .font(.body)
                .foregroundStyle(.background)
                .lineLimit(3)
            
            HStack{
                HStack{
                    Button(action: {
                        thumbupButtonDidTap()
                    }){
                        HStack(spacing: 8.0){
                            if reaction?.reactionType == .UP{
                                Image(systemName: "hand.thumbsup.fill")
                            }else{
                                Image(systemName: "hand.thumbsup")
                            }
                            
                            
                            Text(reaction.map{ String($0.up)} ?? "" )
                                .font(.caption)
                                .fontWeight(.regular)
                                .foregroundStyle(Color.primary)
                        }
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Divider()
                        .fixedSize()
                        .padding(.horizontal, 4.0)
                    
                    Button(action: {
                        thumbsdownButtonDidTap()
                    }){
                        if reaction?.reactionType == .DOWN{
                            Image(systemName: "hand.thumbsdown.fill")
                        }else{
                            Image(systemName: "hand.thumbsdown")
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
                .padding(.horizontal, 12.0)
                .padding(.vertical, 4.0)
                .background(Color.white)
                .clipShape(.capsule)
             
                
                HStack(spacing: 8.0){
                    Image(systemName: "clock")
                                            
                    Text("07:21 ~ 08:30")
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundStyle(Color.primary)
                }
                .padding(.horizontal, 12.0)
                .padding(.vertical, 4.0)
                .background(Color.white)
                .clipShape(.capsule)
            }
            .padding(.top)
        }
        .padding()
        .background(Color.primary)
        .clipShape(RoundedRectangle(cornerRadius: 24.0))
        .task {
            do{
                self.reaction = try await talk.reaction
            }catch{
                print(error)
            }
        }
    }
    
    
    
    private func thumbupButtonDidTap(){
        Task{
            do{
                if self.reaction?.reactionType == .UP{
                    try await talk.cancelUp()
                    self.reaction = try await talk.reaction
                }else{
                    try await talk.up()
                    self.reaction = try await talk.reaction
                }
            }catch{
                
            }
        }
    }
    
    private func thumbsdownButtonDidTap(){
        Task{
            do{
                if self.reaction?.reactionType == .DOWN{
                    try await talk.cancelDown()
                    self.reaction = try await talk.reaction
                }else{
                    try await talk.down()
                    self.reaction = try await talk.reaction
                }
            }catch{
                
            }
        }
    }
    
}

#Preview {
    let talk = Talk(
        id: 1,
        conferenceId: 1,
        name: "Glober Service",
        description: "Glovber Service Glovber Service Glovber Service Glovber Service Glovber Service Glovber Service",
        speaker: Speaker(
            id: 1,
            name: "Brain",
            introduce: "Hello",
            profileImageURL: "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D"
        )
    )

        
    return JoinedTalkCard(talk: talk)
        .padding()
}
