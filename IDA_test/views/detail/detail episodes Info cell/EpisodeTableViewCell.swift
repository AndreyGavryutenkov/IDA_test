//
//  ImageInfoTableViewCell.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//

import UIKit

struct EpisodeTableViewCellObject {
    let url: URL?
}


class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet var lblEpisodeURL: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}



extension EpisodeTableViewCell: BaseTableViewCell{
    func configure(for object: Any?) {
        guard let episode = object as? EpisodeTableViewCellObject else { return }
        
        self.lblEpisodeURL.text = episode.url?.absoluteString
        
    }
}


