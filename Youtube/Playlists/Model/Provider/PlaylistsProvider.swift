//
//  PlaylistsProvider.swift
//  Youtube
//
//  Created by user228543 on 10/12/22.
//

import Foundation
protocol PlaylistsProviderProtocol{
    func getPlaylists(channelId : String) async throws -> PlaylistModel
}

class PlaylistsProvider : PlaylistsProviderProtocol{
    func getPlaylists(channelId: String) async throws -> PlaylistModel {
        let queryParams : [String:String] = ["part":"snippet,contentDetails",
                                             "channelId":channelId]

        let requestModel = RequestModel(endpoint: .playlist, queryItems: queryParams)
        
        do{
            let model = try await ServiceLayer.callService(requestModel, PlaylistModel.self)
            return model
        }catch{
            print(error)
            throw error
        }
    }
       
    
}
