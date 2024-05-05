//
//  basicUIApp.swift
//  basicUI
//
//  Created by 고희정 on 3/15/24.
//

import SwiftUI

@main //처음 시작하는
struct basicUIApp: App {
    var body: some Scene {
        WindowGroup { //endpoint
            MainView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
