//
//  ThirdStep.swift
//  SharePlays
//
//  Created by 고희정 on 4/19/24.
//

import Foundation
import Spatial
import GroupActivities

//start function
func startSession() async throws {
    let activity = ContentView()//session이 시작될 View (예시)
    //let activitySuccess=try await activity
}

//metadata about your app
struct UVRProject: GroupActivity {
    var metadata : GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        
        metadata.title = "Let's Shareplay!🫠"
        return metadata
    }
    static var activityIdentifier = "heejeong.SharePlays"
}

//message about current state

/// e,g) score, userAge, model3D's name ..... -> Data type : Codable
///
struct ReadyStatMessage: Codable {
    let ready : Bool
    
}

var sessionInfo: AppSharePlayInfo? = nil

class AppSharePlayInfo : ObservableObject {
    @Published var session : GroupSession <UVRProject>?
    var messenger : GroupSessionMessenger?
    var reliableMessenger : GroupStateObserver?
    
    
}
