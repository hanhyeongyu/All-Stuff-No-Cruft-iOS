//
//  ContentView.swift
//  AllStuffNoCruft
//
//  Created by 한현규 on 8/23/24.
//

import SwiftUI
import Conference

struct ContentView: View {
    var body: some View {
        TabView{
            ConferenceHome()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            MyPage()
                .tabItem {
                    Image(systemName: "person")
                    Text("MyPage")
                }
        }
        
    }

}

#Preview {
    ContentView()
}
