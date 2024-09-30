//
//  AllStuffNoCruftApp.swift
//  AllStuffNoCruft
//
//  Created by 한현규 on 8/23/24.
//

import SwiftUI
import User

@main
struct AllStuffNoCruftApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    
    @State
    private var user: User
    
    init(){
        user = User()
    }
    
    
    var body: some Scene {
        WindowGroup {
            if user.isSignIn{
                ContentView()
                    .environment(user)
            }else{
                SignIn()
                    .environment(user)
            }
        }
    }
}
