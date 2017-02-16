import UIKit

extension UITableView {
    func resignFirstResponderVisibleRows() {
        let paths = self.indexPathsForVisibleRows
        paths?.forEach{ [weak self] index in
            let cell = self?.cellForRow(at: index)
            cell?.contentView.subviews.forEach{$0.resignFirstResponder()}
        }
    }
}
