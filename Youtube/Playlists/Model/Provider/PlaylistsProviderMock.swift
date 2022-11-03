//
//  PlaylistsProviderMock.swift
//  Youtube
//
//  Created by user228543 on 10/12/22.
//

import Foundation

class PlaylistsProviderMock : PlaylistsProviderProtocol{
    
    func getPlaylists(channelId: String) async throws -> PlaylistModel {
        guard let model = Utils.parseJson(jsonName: "Playlists", model: PlaylistModel.self)else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
}
