//
//  ContentView.swift
//  tracking
//
//  Created by 고희정 on 4/12/24.
//

import SwiftUI
import RealityKit
import RealityKitContent



struct ContentView: View {

    @State private var enlarge = false
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    @Environment(\.dismissWindow) var dismissWindow

    var body: some View { // async - await세트로 기입할 것
        Toggle("Hand Tracker",isOn: $showImmersiveSpace ) //$이 필요한 이유는 다른 스페이스로 넘어가니까~서로 다른 뷰로 넘어가므로 t/f 처리를 위해.
            .toggleStyle(.button)
            .padding()
            .onChange(of: showImmersiveSpace) { _, newValue in // 특정 레이블을 사용하지 않겠다! = _
                Task { @MainActor in
                    if newValue {
                        switch await openImmersiveSpace (id: cubeMeshInteractionID) {
                        case .opened :
                            immersiveSpaceIsShown = true
                            dismissWindow() //변수 / action ()
                        case .error, .userCancelled :
                            fallthrough
                        default:
                            immersiveSpaceIsShown=false
                        }
                    }
                    
                }
            }
        
    } // } :  2개 오는거 체크해서 body 확인~~
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
