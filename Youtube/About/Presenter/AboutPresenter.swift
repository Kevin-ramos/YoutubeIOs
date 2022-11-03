//
//  AboutPresenter.swift
//  Youtube
//
//  Created by user228543 on 10/13/22.
//

import Foundation

protocol AboutViewProtocol: AnyObject{
    
    func getAbout(channelLists : [ChannelModel.Items])
    
}

class AboutPresenter{
    weak var delegate : AboutViewProtocol?
    var provider : AboutProviderProtocol
    
    init(delegate: AboutViewProtocol? , provider: AboutProviderProtocol = AboutProvider()) {
        self.delegate = delegate
        self.provider = provider
        
        #if DEBUG
        if MockManager.shared.runAppWithMock {
            self.provider = AboutProviderMock()
            
        }
        #endif
    }
    @MainActor
    func getAbout() async{
        do{
            let channels = try await provider.getChannel(channelId: Constants.channelId).items
            delegate?.getAbout(channelLists: channels)
        }catch{
            print(error)
        }
        
    }
    
    
}
