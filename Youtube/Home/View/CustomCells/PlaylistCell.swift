//
//  PlaylistCell.swift
//  Youtube
//
//  Created by user228543 on 10/6/22.
//

import UIKit
import Kingfisher
class PlaylistCell: UITableViewCell {

    @IBOutlet weak var dotsImage: UIImageView!
    @IBOutlet weak var namePlaylist: UILabel!
    @IBOutlet weak var numberVideosPlaylist: UILabel!
    @IBOutlet weak var countVideos: UILabel!
    @IBOutlet weak var imagePlaylist: UIImageView!
    
    var didTapDotsButton : (()->Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }

    func configView(){
        dotsImage.image = UIImage(named: "dots")?.withRenderingMode(.alwaysTemplate)
        dotsImage.tintColor = UIColor(named: "whiteColor")
        selectionStyle = .none

    }
    
    @IBAction func dosButton(_ sender: Any) {
        if let tap = didTapDotsButton{
            tap()
        }
    }
    func configCell(model : PlaylistModel.Item){
        namePlaylist.text = model.snippet.title
        numberVideosPlaylist.text = "\(model.contentDetails.itemCount )  videos"
        countVideos.text = "\(model.contentDetails.itemCount)"
        if let playlistUrl = model.snippet.thumbnails.medium?.url, let url = URL(string: playlistUrl){
            imagePlaylist.kf.setImage(with: url)
        }
    }
    
}
