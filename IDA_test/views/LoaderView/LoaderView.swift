import Foundation
import UIKit

/**
 LoaderView. Class for view that displaying some progress
 */
class LoaderView: BaseView {
    
    @IBOutlet weak var progressLabel: UILabel!
    
    func setProgress(_ progress: Double) {
        progressLabel.isHidden = false
        progressLabel.text = "Progress: \(Int(progress * 100))%"
    }
}
