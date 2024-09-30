//
//  JoinedTalk.swift
//
//
//  Created by 한현규 on 9/2/24.
//

import SwiftUI
import UIUtil
import AVKit
import LogUtil


struct JoinedTalk: View {
    
    private let talk: Talk
    
    
    @Binding
    private var path: NavigationPath

    @State
    private var talkVideos: [TalkVideo]
            
    @State
    private var slides: [Slide]
    
    private let avPublisher = NotificationCenter.default.publisher(for: AVPlayerItem.newAccessLogEntryNotification)
    
    @State
    private var currentSlide: Slide?
                
    
    init(talk: Talk, path: Binding<NavigationPath>) {
        self.talk = talk
        self._path = path
        self.talkVideos = []
        self.slides = []
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                JoinedTalkCard(talk: talk)

               
                
                ForEach(talkVideos){ talkVideo in
                    let player = AVPlayer(url: talkVideo.videoURL)
                    PlayerViewController(player: player)
                        .aspectRatio(1.5, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                }
                
                                
                    
                ForEach(slides){ slide in
                    Button(action: {
                        slideButtonDidTap(slide: slide)
                    }){
                        Text(slide.name)
                            .bold()
                    }
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle(talk.name)
        .navigationBarTitleDisplayMode(.large)
        .fullScreenCover(item: $currentSlide){ slide in
            SlideView(slide: slide)
        }
        .onReceive(avPublisher){ notification in
            guard let playerItem = notification.object as? AVPlayerItem,
                let lastEvent = playerItem.accessLog()?.events.last else {
                return
            }

            let indicatedBitrate = lastEvent.indicatedBitrate
            
            Log.d("""
                PLAYER LOG:
                EVENT: \(lastEvent)
                INDICATED BITRATE: \(indicatedBitrate)
                PLAYBACK RELATED LOG EVENTS
                PLAYBACK START DATE: \(lastEvent.playbackStartDate)
                PLAYBACK SESSION ID: \(lastEvent.playbackSessionID)
                PLAYBACK START OFFSET: \(lastEvent.playbackStartOffset)
                PLAYBACK TYPE: \(lastEvent.playbackType)
                STARTUP TIME: \(lastEvent.startupTime)
                DURATION WATCHED: \(lastEvent.durationWatched)
                NUMBER OF DROPPED VIDEO FRAMES: \(lastEvent.numberOfDroppedVideoFrames)
                NUMBER OF STALLS: \(lastEvent.numberOfStalls)
                SEGMENTS DOWNLOADED DURATION: \(lastEvent.segmentsDownloadedDuration)
                DOWNLOAD OVERDUE: \(lastEvent.downloadOverdue)                
                """)
        }
        .task {
            do{
                self.talkVideos = try await talk.talkVideos
                self.slides = try await talk.slides
            }catch{
                
            }
            
        }
                
    }
    

       
       
    
    private func slideButtonDidTap(slide: Slide){
        currentSlide = slide
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
    
    return JoinedTalk(talk: talk, path: .constant(.init()))
}
