//
//  PlaylistsPresenter.swift
//  Youtube
//
//  Created by user228543 on 10/12/22.
//

import Foundation

protocol PlaylistsViewProtocol: AnyObject{
    
    func getPlaylists(playlistsList : [PlaylistModel.Item])
    
}

class PlaylistsPresenter{
    
    weak var delegate : PlaylistsViewProtocol?
    var provider : PlaylistsProviderProtocol
    
    init(delegate: PlaylistsViewProtocol, provider: PlaylistsProviderProtocol = PlaylistsProvider()) {
        self.delegate = delegate
        self.provider = provider
        #if DEBUG
        if MockManager.shared.runAppWithMock{
            self.provider = PlaylistsProviderMock()
        }
        #endif
    }
    
    func getPlaylists() async {
        do{
            let playlists = try await provider.getPlaylists(channelId: Constants.channelId).items
            delegate?.getPlaylists(playlistsList: playlists)
        }catch{
            debugPrint(error.localizedDescription)
        }
        
    }
    
    
}
