//
//  SecondStep.swift
//  SharePlays
//
//  Created by 고희정 on 4/19/24.
//

import GroupActivities
import Foundation
import Spatial
import UIKit

struct OrderTogether: GroupActivity {
    
    //unique share play ID
    static let activityIndentifier = "heejeong.SharePlays"
    let orderID : UUID
    var containerName:String
    
    var metadata : GroupActivityMetadata {
        var metadata = GroupActivityMetadata()
        metadata.title = "Let's Shareplay!🫠"
        metadata.subtitle = containerName
        metadata.previewImage = UIImage(systemName: "shareplay")?.cgImage
        metadata.type = .listenTogether
        return metadata
    }
}
