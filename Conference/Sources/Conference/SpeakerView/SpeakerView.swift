//
//  SpeakerView.swift
//
//
//  Created by 한현규 on 9/1/24.
//

import SwiftUI
import UIUtil

struct SpeakerView: View {
    
    private let speaker: Speaker
            
    init(speaker: Speaker){
        self.speaker = speaker
    }
    
    var body: some View {
        ScrollView {
            VStack{
                CircleImage(url: speaker.profile)
                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .padding(64.0)
            
                VStack{
                    Text(speaker.name)
                    .font(.title3)
                    .fontWeight(.bold)
                }
                
            }
            
            
            VStack(alignment: .leading){
                Text("Profile")
                .font(.title3)
                .fontWeight(.bold)
                
                Divider()
                
                Text(speaker.introduce)
            }
            .padding()
            
        }
    }
}

#Preview {
    let speaker = Speaker(
        id: 1,
        name: "Lenna",
        introduce: "Hello~",
        profileImageURL: "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D"
    )
    return SpeakerView(speaker: speaker)
}
