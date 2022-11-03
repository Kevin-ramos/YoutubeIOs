//
//  VideosPresenter.swift
//  Youtube
//
//  Created by user228543 on 10/12/22.
//

import Foundation

protocol VideosViewProtocol: AnyObject{
    func getVideos(videoList: [VideoModel.Item])
}

class VideosPresenter {
    private weak var delegate : VideosViewProtocol?
    private var provider : VideoProviderProtocol
    
    init(delegate : VideosViewProtocol, provider : VideoProviderProtocol = VideosProvider()){
        self.delegate = delegate
        self.provider = provider
        #if DEBUG
        if MockManager.shared.runAppWithMock{
            self.provider = VideosProviderMock()
        }
        #endif
    }
    @MainActor
    func getVideos() async{
        do{
            let videos = try await provider.getVideos(channelId: Constants.channelId).items
            delegate?.getVideos(videoList: videos)
        }catch{
            debugPrint(error.localizedDescription)
        }
    }
}
