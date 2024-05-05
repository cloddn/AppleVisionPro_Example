//
//  SeaCreatureDetailView.swift
//  RotationGesture
//
//  Created by 고희정 on 4/19/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct SeaCreatureDetailView: View {
    
    //Properties
    let modelName: String
    
    //Update를 계속할 수 있도록 상태를 관찰
    @State private var horizontalRotation = CGFloat.zero
    @State private var verticalRotation = CGFloat.zero
    
    @State private var endHorizontalRotation = CGFloat.zero
    @State private var endVerticalRotation = CGFloat.zero
    
    var body: some View {
        Model3D(named: modelName, bundle: 
                    realityKitContentBundle)
        
        //horizontal rotation action
        .rotation3DEffect(.degrees(horizontalRotation), axis: .y)
        .rotation3DEffect(.degrees(-verticalRotation), axis: .x)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    horizontalRotation = value.translation.width + endHorizontalRotation
                    verticalRotation = value.translation.height + endVerticalRotation
                })
                .onEnded({ value in
                    endHorizontalRotation = value.translation.width
                    endVerticalRotation = value.translation.height
                })
        )
        
    }
}

#Preview {
    SeaCreatureDetailView(modelName: "FishScene")
}
