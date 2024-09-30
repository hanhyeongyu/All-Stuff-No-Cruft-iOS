//
//  ConferenceDetail.swift
//
//
//  Created by 한현규 on 8/23/24.
//

import SwiftUI
import AppUtil
import UIUtil

import Kingfisher



struct ConferenceView: View {
    
    
    private let conference: Conference
    
    @Binding
    private var path: NavigationPath
    
    @State
    private var talks: [Talk]
    
    @State
    private var speakers: Set<Speaker>
        
    @State
    private var error: Error? = nil
    
    @State
    private var showError: Bool = false
    
    private let columns: [GridItem] = Array(repeating: GridItem(spacing: 8.0), count: 4)

        
    
    init(conference: Conference, path: Binding<NavigationPath>) {
        self.conference = conference
        self.talks = []
        self.speakers = []
        self._path = path
    }
    
    var body: some View {
        
        VStack{
            ScrollViewReader{ proxy in
                List {
                    ConferenceCard(conference: conference)
                        .aspectRatio(3/2, contentMode: .fit)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init())
                    
                    Section(
                        header: Text("Program")
                            .font(.title3)
                            .fontWeight(.bold)
                    ){
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            LazyHStack(spacing: 16.0){
                                ForEach(talks){ talk in
                                    TalkRow(talk: talk)
                                        .onTapGesture {
                                            path.append(talk)
                                        }
                                }
                            }
                            .padding()
                        }
                        .aspectRatio(2 / 1, contentMode: .fit)
                        .listRowInsets(.init())
                        .listRowSeparator(.hidden)
                        .listRowBackground(EmptyView())
                    }
                    .foregroundStyle(.primary)
                    
                    
                    Section(
                        header: Text("Speaker")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                    ){
                        LazyVGrid(columns: columns){
                            ForEach(Array(speakers)){ speaker in
                                SpeakerRow(speaker: speaker)
                                    .onTapGesture {
                                        path.append(speaker)
                                    }
                            }
                        }
                        .padding()
                    }
                    .foregroundStyle(.primary)
                    .listRowBackground(EmptyView())
                    
                    
                    
                    Section(
                        header: Text("Description")
                            .font(.title3)
                            .fontWeight(.bold)
                        
                    ){
                        Text(conference.information.content)
                    }
                    .foregroundStyle(.primary)
                    .listRowBackground(EmptyView())
                    
                    
                    
                    Section(
                        header: Text("Location")
                            .font(.title3)
                            .fontWeight(.bold)
                    ){
                        VStack(alignment: .leading){
                            MapView(
                                coordinate: conference.address.coordinate.clLocationCoordinate()
                            )
                            .frame(height: 200.0)
                            Text(conference.address.fullAddress())
                        }
                    }
                    .foregroundStyle(.primary)
                    .listRowSeparator(.hidden)
                    .listRowBackground(EmptyView())
                    
                    
                }
                .listStyle(.plain)
            }
            
            
            Spacer()
            
            Button(action: {
                joinButtonDidTap()
            }){
                Text("참여")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            
        }
        .alert(error?.localizedDescription ?? "Error", isPresented: Binding(value: $error)){
            Button("OK", role: .cancel){
            }
        }
        .background(Color(UIColor.secondarySystemBackground))
        .ignoresSafeArea(edges: .top)
        .task {
            self.talks = (try? await conference.talks) ?? []
            self.speakers = Set(talks.map(\.speaker))
        }
        .navigationDestination(for: Talk.self, destination: { talk in
            TalkView(talk: talk, path: $path)
        })
        .navigationDestination(for: Speaker.self) { speaker in
            SpeakerView(speaker: speaker)
        }
    }
    
    
    private func joinButtonDidTap(){
        Task{
            do{
                try await conference.join()
                await MainActor.run {
                    path.removeLast()
                }
            }catch{
                self.error = error
                self.showError = true                
            }
        }
    }
    

    
    
}


#Preview {
    let conference = Conference(
        id: 1,
        name: "Spring camp",
        information: Information(
            content: """
스프링캠프 2024는 애플리케이션 서버 개발자들과 함께 가치있는 기술에 관한 정보과 경험을 '공유'하고, 참가한 사람들과 함께 '인연'을 만들고, 시끌벅적하게 즐길 수 있는 개발자들을 위한 '축제'를 목표로 하는 비영리 컨퍼런스입니다.
""",
            contentType: "Plan"
        ),
        address: Address(
            city: "서울시",
            street: "강남구 남부순환로 3104",
            zipCode: "2352",
            coordinate: Coordinate(
                latitude: 37.49699460099485,
                longitude: 127.07202388832731
            )
        ),
        schedule: Schedule(
            meetingStartAt: Date(),
            meetingEndAt: Date(),
            registerStartAt: Date(),
            registerEndAt: Date()
        ),
        capacity: Capacity(
            maxCapacity: 100,
            availableCapacity: 70,
            currentCapacity: 30
        ),
        price: Price(amount: 300000, currency: "won"),
        posterURL: "https://images.unsplash.com/photo-1560439514-4e9645039924?q=80&w=3870&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    )
        
    return ConferenceView(conference: conference, path: .constant(.init()))
}



