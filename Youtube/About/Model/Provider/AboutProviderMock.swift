//
//  AboutProviderMock.swift
//  Youtube
//
//  Created by user228543 on 10/13/22.
//

import Foundation

class AboutProviderMock: AboutProviderProtocol{
    func getChannel(channelId: String) async throws -> ChannelModel {
        guard let model = Utils.parseJson(jsonName: "Channel", model: ChannelModel.self)else{
            throw NetworkError.jsonDecoder
        }
        return model
    }
    
}
