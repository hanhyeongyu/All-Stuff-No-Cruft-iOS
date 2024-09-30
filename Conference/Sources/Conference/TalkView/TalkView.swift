//
//  TalkView.swift
//
//
//  Created by 한현규 on 8/30/24.
//

import SwiftUI
import UIUtil

struct TalkView: View {
    
    private let talk: Talk
    
    @Binding
    private var path: NavigationPath
    
    init(talk: Talk, path: Binding<NavigationPath>) {
        self.talk = talk
        self._path = path
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            VStack(alignment: .leading){
                Text("01")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("15:15 ~16:00")
                    
                    
                
                Text(talk.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 8.0)
                    
                Text(talk.description)
                    .lineLimit(nil)
                    .padding(.top, 8.0)

            }
            .padding()
                
            Spacer()
            
            Divider()
            
            HStack{
                CircleImage(url: talk.speaker.profile)
                    .aspectRatio(1.0, contentMode: .fit)
                    .onTapGesture {
                        path.append(talk.speaker)
                    }
                
                
                VStack {
                    Text(talk.speaker.name)
                        .font(.caption)
                    
                    Text(talk.speaker.introduce)
                        .font(.caption)
                }
            }
            .aspectRatio(1 / 5 , contentMode: .fit)
            .padding()
            
        }
        .navigationTitle(talk.name)
        .navigationBarTitleDisplayMode(.inline)
    }
        
}

#Preview {
    let talk = Talk(
        id: 1,
        conferenceId: 1,
        name: "Glober Service for Timezone",
        description: "Glovber Service for Timezone of SpringBoot",
        speaker: Speaker(
            id: 1,
            name: "Brain",
            introduce: "Hello",
            profileImageURL: "https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D"
        )
    )
    return TalkView(talk: talk, path: .constant(.init()))
}
