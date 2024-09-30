//
//  TalkRow.swift
//
//
//  Created by 한현규 on 8/26/24.
//

import SwiftUI
import AppUtil
import UIUtil

struct TalkRow: View {
    
    private let talk: Talk
    
    init(talk: Talk) {
        self.talk = talk
    }
    
    var body: some View {
        
        HStack{
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 8.0){
                    Text(talk.name)
                        .lineLimit(1)
                    
                    Text(talk.description)
                        .lineLimit(2)
                }
                                                
                Spacer()
                
                HStack{
                    CircleImage(url: talk.speaker.profile)
                        .frame(width: 50.0, height: 50.0)
                    
                    Text(talk.speaker.name)
                }
            }
            
            Spacer()
        }
        //.frame(width: 300.0, height: 150.0)
        .aspectRatio(2 / 1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
        .padding()
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
                    
    }
    
}

#Preview {
    let talk = Talk(
        id: 2,
        conferenceId: 1,
        name: "Glober Service for Timezone",
        description: "Glovber Service Glovber Service Glovber Service Glovber Service Glovber Service Glovber Service",
        speaker: Speaker(
            id: 1,
            name: "Brain",
            introduce: "Hello",
            profileImageURL: "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D"
        )
    )

    return TalkRow(talk:talk)
        .padding()
        .aspectRatio(2 / 1, contentMode: .fit)
        .background(Color(UIColor.secondarySystemBackground))
        
}
