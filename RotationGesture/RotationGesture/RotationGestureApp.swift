//
//  RotationGestureApp.swift
//  RotationGesture
//
//  Created by 고희정 on 4/19/24.
//

import SwiftUI

@main
struct RotationGestureApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        WindowGroup(id: "creaturewindow", for: String.self) { $modelName in
            SeaCreatureDetailView(modelName: modelName ?? "Drummer")
                .padding3D(.top,400)
                .persistentSystemOverlays(.hidden)
        } //String-
        .windowStyle(.volumetric)
        .defaultSize(width: 0.8, height: 0.6, depth: 0.4, in: .meters)
    }
}
