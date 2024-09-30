//
//  ScheduleRow.swift
//
//
//  Created by 한현규 on 9/2/24.
//

import SwiftUI
import AppUtil

struct ScheduleRow: View {
    
    private let talk: Talk
    
    init(talk: Talk) {
        self.talk = talk
    }
    
    
    var body: some View {
        
        HStack(alignment: .top){
            VStack(alignment: .center){
                Text(Formatter.timeFormatter.string(from: Date.now))
                    .font(.callout)
                    .fontWeight(.bold)
                
                Text("50 Min")
                    .font(.caption)
                    .fontWeight(.light)
            }
            .frame(width: 100)
                                                
            
            VStack(alignment: .leading){
                Text(talk.name)
                    .lineLimit(2)
                
                Text(talk.speaker.name)
                    .lineLimit(3)
                    
            }
            
            Spacer()
        }
                
    }
}

#Preview {
    let talk = Talk(
        id: 2,
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

    return ScheduleRow(talk: talk)
}
