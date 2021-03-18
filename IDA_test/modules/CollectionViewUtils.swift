import Foundation
import UIKit

/**
    CollectionViewUtils. Used to configure cells for specific cell descriptors
 */
struct TableViewCellDescription {
    let cellType: BaseTableViewCell.Type
    var object: Any?

    init(cellType: BaseTableViewCell.Type, object: Any?) {
        self.cellType = cellType
        self.object = object
    }
}

let UICollectionViewAutomaticDimension: CGFloat = -1.0

extension UITableView {

    func register<T: BaseTableViewCell>(_ classType: T.Type) {
        register(UINib(nibName: classType.cellIdentifier(), bundle: nil),
                forCellReuseIdentifier: classType.cellIdentifier())
    }

    func configureCell(with cellDescription: TableViewCellDescription, for indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: cellDescription.cellType.cellIdentifier(), for: indexPath)
        if let baseCell = cell as? BaseTableViewCell {
            baseCell.configure(for: cellDescription.object)
        }

        return cell
    }
}

