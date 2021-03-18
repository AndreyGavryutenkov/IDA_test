//
//  ImageInfoTableViewCell.swift
//  IDA_test
//
//  Created by Andrey Gavryutenkov on 3/18/21.
//

import UIKit

class ImageInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var lblAuthor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}



extension ImageInfoTableViewCell: BaseTableViewCell{
    func configure(for object: Any?) {
        guard let item = object as? ImageInfo else { return }
        lblAuthor.text = item.author

    }
}
