//
//  Entity.swift
//  tracking
//
//  Created by 고희정 on 4/12/24.
//

import ARKit
import RealityKit

//관찰이 되어야해요~~~25-30fps
//Entity 모델을 계속 관찰하겠따~~
@Observable
@MainActor


//Struct, Class 이름으로 자동적으로 완성되어요~~!
class EntityModel {
    //MARK: properties - 기본 public
    
    let arSession = ARKitSession() //AR session을 열어줘야해~~~~
    let handTracking = HandTrackingProvider()
    let sceneReconstruction = SceneReconstructionProvider()   //실시간으로 scene을 reconstruction해줘야해~
    
    //MARK: AR session에서 사용하게 될 entity를 초기화및 선언
    var contentEntity = Entity()
    
    
    private var meshEntity = [UUID: ModelEntity]() //ModelEntity() ㄴㄴ링 //key:value
    private var fingerEntity: [HandAnchor.Chirality:ModelEntity] = [
        .left: .creatingFingerTip(),
        .right: .creatingFingerTip() ]//Custom type가능
    
    var errorState=false
    //HandTracking
    //Add Entity
    func setup3DcontentEntity() -> Entity {
        for entity in fingerEntity.values{ //key:value
            contentEntity.addChild(entity)
        }
        return contentEntity
    }
    //realtime으로 hangtracking function HandTracking 25-30fps
    func processHandUpdating () async {
        //Loop
        //function자체도 비동기로 가져가주기 위해
        for await updateHand in handTracking.anchorUpdates {
            let handAnchor = updateHand.anchor
            
            //MARK: guard 기법
            guard//유저에 대한 데이터가 없어도 Return시킴! guard let currentUser=currentUser else {return}
                handAnchor.isTracked,
                let middleFingerTip = handAnchor.handSkeleton?.joint(.middleFingerTip),
                middleFingerTip.isTracked else {continue}
                
            let originFromMiddleFingerTip = handAnchor.originFromAnchorTransform * middleFingerTip.anchorFromJointTransform //hand & finger's joint tracking
            
            fingerEntity[handAnchor.chirality]?.setTransformMatrix(originFromMiddleFingerTip, relativeTo: nil)//=null )
            
        }
    }
    //data provider supported : Bool
    var dataProviderAreSupported: Bool {
        HandTrackingProvider.isSupported && SceneReconstructionProvider.isSupported
        
    }
   
    //starting hand tracking point
    var isStartToRun: Bool {
        handTracking.state == .initialized && sceneReconstruction.state == .initialized
    }
    
    // Scene Reconstruction
    func processReconstructionUpdates() async {
        for await update in sceneReconstruction.anchorUpdates{
            let meshAnchor = update.anchor
            
            //guard 기법
            //try? await -> 이 자체로 외우세요~~~~
            guard let shape = try? await ShapeResource.generateStaticMesh(from: meshAnchor)
            else { continue }
            
            switch update.event {//anchor때문에 event이다~
            case .added:
                let entity = ModelEntity()
                entity.transform = Transform(matrix: meshAnchor.originFromAnchorTransform)
                entity.collision = CollisionComponent(shapes: [shape], isStatic: true )
                
                entity.components.set(InputTargetComponent())
                
                entity.physicsBody = PhysicsBodyComponent(mode: .static)
                meshEntity[meshAnchor.id]=entity
                contentEntity.addChild(entity)
                
                
            case .updated:
                guard let entity = meshEntity[meshAnchor.id] else {continue} //guard- else {continue} 항상 같이옴
                entity.transform = Transform(matrix:meshAnchor.originFromAnchorTransform)
                entity.collision?.shapes = [shape]
                
                        
            case .removed:
                meshEntity[meshAnchor.id]?.removeFromParent()
                meshEntity.removeValue(forKey: meshAnchor.id)
                
            }
                    
        }
    }
    func addCube(pinchLocation: SIMD3<Float>){
        let placementLocation = pinchLocation + SIMD3<Float>(0, 0.3, 0) // 나타낼 지점: xyz좌표를 지정함
        
        let entity =  ModelEntity(mesh: .generateBox(size: 0.2,cornerRadius: 0.1), materials: [SimpleMaterial(color: .purple, isMetallic: false)] ,collisionShape: .generateBox(size: SIMD3<Float>(repeating: 0.1)),mass: 1.0)
        
        entity.setPosition(placementLocation, relativeTo: nil)
        entity.components.set(InputTargetComponent(allowedInputTypes:.indirect))
        
        let material = PhysicsMaterialResource.generate(friction: 0.8, restitution: 0.0)
        
        entity.components.set(
            PhysicsBodyComponent(shapes: entity.collision!.shapes,
                                 density: 1.0 ,
                                 material: material,
                                 mode: .dynamic
                                )
        )
        contentEntity.addChild(entity)
    }
}

//add cube <- 3D Model
