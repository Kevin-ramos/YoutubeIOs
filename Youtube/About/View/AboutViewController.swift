//
//  AboutViewController.swift
//  Youtube
//
//  Created by user228543 on 10/3/22.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var aboutLabel: UILabel!
    lazy var presenter = AboutPresenter(delegate: self)
    var about : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task{
            await presenter.getAbout()
            aboutLabel.text = about
            
        }
        
    }

    
    

}

extension AboutViewController: AboutViewProtocol{
    func getAbout(channelLists: [ChannelModel.Items]) {
        print("gaaaaaaaaaaa" , channelLists.count)
        self.about = channelLists.first?.snippet.description ?? ""
    }
    
}
