//
//  trackingApp.swift
//  tracking
//
//  Created by 고희정 on 4/12/24.
//

import SwiftUI

@main
@MainActor

struct HandTrackerApp: App {
    //properties
    
    @State private var model = EntityModel()
    @MainActor init() {} //특정 thread를 시작함~~을 알려줌
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()

        }.windowStyle(.volumetric)
        
        WindowGroup(id:"error"){
            Text("Error immersiveSpace")
        }
            
        ImmersiveSpace(id: cubeMeshInteractionID) {
            CubeMesh()
            .environment(model)
        }
    }
}
