//
//  ModelEntity.swift
//  tracking
//
//  Created by 고희정 on 4/12/24.
//
//Handtracking model

import ARKit
import RealityKit


extension ModelEntity {
    class func creatingFingerTip()-> ModelEntity {
        let entity = ModelEntity(mesh: .generateSphere(radius: 0.006), materials: [UnlitMaterial(color: .orange)], collisionShape: .generateSphere(radius: 0.006) , mass: 0.0)
        entity.components.set(PhysicsBodyComponent(mode: .kinematic))
        entity.components.set(OpacityComponent(opacity: 1.0))
        
        return entity
    }
    
    //class func creatingFingerTip(leftHand~이렇게 파라미터를 넣어줄 수 있다~~) () -> ModelEntity: 반환값
    
}
