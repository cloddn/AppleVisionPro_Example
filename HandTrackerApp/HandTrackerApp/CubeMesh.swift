//
//  CubeMesh.swift
//  tracking
//
//  Created by 고희정 on 4/12/24.
//

import SwiftUI
import RealityKit

let cubeMeshInteractionID = "cubeMeshInteractionID"

struct CubeMesh: View {
    //properties
    @Environment(EntityModel.self) var model //custom handtracking model ( File 전체를 model로 갖고왔따~~) 
    @Environment(\.dismissImmersiveSpace) var dismissImmersive //ARKit은 Window에서 가져올 수 없고, Immersive=Space여야됨.
    @Environment(\.openImmersiveSpace) var openImmersive
    var body: some View {
//        //async로 Stack을 관리
//        LazyVStack{
//            Text("야호")
//            Text("야호")
//            Text("야호")
//            Text("야호")
//        }
        //RealityView-> ImmersiveView(AR만 하는경우로 사용)로 해주는 경우가 있음
        RealityView { entity in
            entity.add(model.setup3DcontentEntity())// Entity model에서 생성되는 3D object를 추가
        }
        //MARK: async
        //특정 action에 대해서 비동기적으로 관리할 수 있다~
        .task {
            do {
                if model.dataProviderAreSupported && model.isStartToRun {
                    try await model.arSession.run([model.sceneReconstruction,model.handTracking])
                }else{
                    await dismissImmersive()
                }
                    
            } catch {
                
            }
        }
        .task {
            await model.processHandUpdating()
        }
        .task {
            await model.processReconstructionUpdates()
            
        }
        .gesture(SpatialTapGesture().targetedToAnyEntity().onEnded{
            value in let locationCube = value.convert(value.location3D, from: .local, to: .scene)
            model.addCube(pinchLocation: locationCube)
        })
        .onChange(of: model.errorState) { oldValue, newValue in
            //OpenWindowAction
            //error
        }
        .task {
            
            
        }
        .task {
            
        }
    }
}

#Preview {
    CubeMesh()
}
