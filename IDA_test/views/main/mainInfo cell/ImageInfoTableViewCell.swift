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
    @IBOutlet weak var lblCharacterType: UILabel!
    @IBOutlet weak var lblAlive: UILabel!
    
    var onReuse: () -> Void = {}
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

      override func prepareForReuse() {
        super.prepareForReuse()
        onReuse()
        imgPhoto.image = nil
      }

}



extension ImageInfoTableViewCell: BaseTableViewCell{
    func configure(for object: Any?) {
        guard let item = object as? RMCharacter else { return }
        lblAuthor.text = item.name
        lblCharacterType.text = "Type: " + item.characterType
        lblAlive.text =  "life status:" +  item.status
        
        guard let url = item.image else { return }
        let requestId = appController?.imageLoader.loadImage(url) { (result) in
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                  self.imgPhoto.image = image
                }
              } catch (let error){
                print(error.localizedDescription)
              }
        }

        onReuse = {
          if let token = requestId {
            appController?.imageLoader.cancelLoad(token)
          }
        }
        
    }
}


