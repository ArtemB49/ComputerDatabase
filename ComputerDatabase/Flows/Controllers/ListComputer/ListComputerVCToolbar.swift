/**
 * Расширение контроллера списка компьютеров для работы с Toolbar
 */

import UIKit

extension ListComputerTableViewController {
    
    func fillToolbar() {
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        let nextButton = UIBarButtonItem(
            title: "Next",
            style: .plain,
            target: self,
            action: #selector(nextDidTap(_:))
        )
        
        let backButton = UIBarButtonItem(
            title: "Back",
            style: .plain,
            target: self,
            action: #selector(backDidTap(_:))
        )
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor.gray
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Page"
        
        let pageLabel = UIBarButtonItem(customView: textLabel)
        
        self.setToolbarItems(
            [
                backButton,
                flexibleSpace,
                pageLabel,
                flexibleSpace,
                nextButton
            ],
            animated: true
        )
        
    }
    
    @objc func nextDidTap(_ sender: UIBarButtonItem) {
        pageNumber += 1
        fetchPage()
        
    }
    
    @objc func backDidTap(_ sender: UIBarButtonItem) {
        pageNumber -= 1
        fetchPage()
    }
}

