//
//  DetailScreenViewController.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import Foundation
import UIKit


class DetailScreenViewController: BaseViewController, BaseViewProtocol, BaseViewControllerOutputProtocol {
    
    typealias ViewClass = DetailScreenView
    typealias OutputClass = DetailScreenViewOutput
    
    
    @IBAction func onBackTapped(_ sender: Any) {
        appController?.flowController.dismissToRoot(animated: true)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.tblEpisodes.delegate = self
        rootView.tblEpisodes.dataSource = self
        rootView.tblEpisodes.tableFooterView = UIView()
        rootView.tblEpisodes.register(EpisodeTableViewCell.self)
    }
    
}

extension DetailScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewOutput?.model?.episodes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let episode = viewOutput?.model?.episodes?[indexPath.row] else { return UITableViewCell() }
        let cell = tableView.configureCell(with: TableViewCellDescription(cellType: EpisodeTableViewCell.self,
                                                                          object: EpisodeTableViewCellObject(url: episode)),
                                           for: indexPath)
        return cell
    }
    
}



extension DetailScreenViewController: DetailScreenViewInput {
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.rootView.imgCharacterImage.image = image
        }
        
    }
    
    func updateUI() {
        
        guard let model = viewOutput?.model else { show(error: "Model lost!"); return }
        
        rootView.lblName.text = model.name
        rootView.lblOriginName.text = model.origin?.name
        rootView.lblOriginURL.text = model.origin?.url
        
        rootView.lblLocationName.text = model.location?.name
        rootView.lblLocationURL.text = model.location?.url
        
        rootView.tblEpisodes.reloadData()
    }
    
}
