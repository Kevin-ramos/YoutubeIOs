//
//  VideosViewController.swift
//  Youtube
//
//  Created by user228543 on 10/3/22.
//

import UIKit

class VideosViewController: UIViewController {
    //1 Asociar la vista con el controller
    @IBOutlet weak var tableViewVideos: UITableView!
    //crear un presenter
    lazy var presenter = VideosPresenter(delegate: self)
    var videosList : [VideoModel.Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        //llamar asincronamente al servicio
        Task{
            await presenter.getVideos()
        }
    }

    // 2 registrar la celda
    func configTableView(){
        let nibVideos = UINib(nibName: "\(VideoCell.self)", bundle: nil)
        tableViewVideos.register(nibVideos, forCellReuseIdentifier: "\(VideoCell.self)")
        
        tableViewVideos.separatorColor = .clear
        tableViewVideos.delegate = self
        tableViewVideos.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
  

}

extension VideosViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let video = videosList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(VideoCell.self)", for: indexPath) as? VideoCell else{
            return UITableViewCell()
        }
        cell.didTapDotsButton = {[weak self] in
            let vc = BottomSheetViewController()
            vc.modalPresentationStyle = .overCurrentContext
            self?.present(vc, animated: false)
        }
        cell.configCell(model: video)
        return cell
    }
    
    
}

//Completar el protocolo
extension VideosViewController : VideosViewProtocol{
    func getVideos(videoList: [VideoModel.Item]) {
        self.videosList = videoList
        tableViewVideos.reloadData()
    }
    
    
}
