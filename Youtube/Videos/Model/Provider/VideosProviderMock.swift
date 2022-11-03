//
//  VideosProviderMock.swift
//  Youtube
//
//  Created by user228543 on 10/12/22.
//

import Foundation

class VideosProviderMock: VideoProviderProtocol{
    
    func getVideos( channelId : String) async throws -> VideoModel{
        guard let model = Utils.parseJson(jsonName: "VideoList", model: VideoModel.self)else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
}
