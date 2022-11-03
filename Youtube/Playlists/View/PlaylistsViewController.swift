//
//  PlaylistsViewController.swift
//  Youtube
//
//  Created by user228543 on 10/3/22.
//

import UIKit

class PlaylistsViewController: UIViewController {
    
    @IBOutlet weak var playlistsTableView: UITableView!
    var playlistsList : [PlaylistModel.Item] = []
    lazy var presenter = PlaylistsPresenter(delegate : self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        Task{
            await presenter.getPlaylists()
        }
    }


    func configTableView(){
        let nib = UINib(nibName: "\(PlaylistCell.self)", bundle: nil)
        playlistsTableView.register(nib, forCellReuseIdentifier: "\(PlaylistCell.self)")
        
        playlistsTableView.separatorColor = .clear
        playlistsTableView.delegate = self
        playlistsTableView.dataSource = self 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension PlaylistsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlistsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playlist = playlistsList[indexPath.row]
        guard let playlistCell = playlistsTableView.dequeueReusableCell(withIdentifier: "\(PlaylistCell.self)", for: indexPath) as? PlaylistCell else{
            return UITableViewCell()
        }
        playlistCell.didTapDotsButton = { [weak self] in
            let vc = BottomSheetViewController()
            vc.modalPresentationStyle = .overCurrentContext
            self?.present(vc, animated: false)
        }
        playlistCell.configCell(model: playlist)
        return playlistCell
    }
    
    
}

extension PlaylistsViewController : PlaylistsViewProtocol{
    func getPlaylists(playlistsList: [PlaylistModel.Item]) {
        self.playlistsList = playlistsList
        playlistsTableView.reloadData()
    }
    
    
}
