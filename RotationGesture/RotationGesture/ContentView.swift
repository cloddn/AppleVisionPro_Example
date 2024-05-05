//
//  ContentView.swift
//  RotationGesture
//
//  Created by 고희정 on 4/19/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @State private var selectedCreature:
    SeaCreatureModel?
    
    //property
    private var seaCreature = [
        //name은 내가 설정~~~ modelName:설정한대로~
        SeaCreatureModel(name: "Fish", modelName: "FishScene"),
        SeaCreatureModel(name: "Clam", modelName: "ClamScene"),
        SeaCreatureModel(name: "Slug", modelName: "SlugScene"),
        SeaCreatureModel(name: "Starfish", modelName: "StarfishScene")
    ]
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismiss) private var dismissWindow
    
    var body: some View {
        //Tapview가 가장 위
        NavigationSplitView {
            List(seaCreature) { creature in
                Button(action: {
                    //detail View에 맞는 데이터 mapping~매핑핑~
                    selectedCreature=creature
                    
                }, label: {
                    Text(creature.name)
                })
                
            }
            .navigationTitle("Aqua Friends")
        } detail: {
            if let selectedCreature {
                Model3D(named: selectedCreature
                    .modelName,
                    bundle:
                    realityKitContentBundle)
                .navigationTitle(selectedCreature.name)
                .toolbar{
                    Button(action: {
                        openWindow(id: "creaturewindow", value: selectedCreature.modelName)
                    }, label: {
                        Text("Volumetric \(selectedCreature.name)")
                    })
                }
            }
            else {
                Text("Select a item list")
                    .font(.largeTitle)
            }
        }

    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
