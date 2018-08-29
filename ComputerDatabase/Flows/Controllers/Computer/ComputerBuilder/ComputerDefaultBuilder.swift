/**
 * Реализация билдера контроллера компьютера
 */
import Foundation
import UIKit

class ComputerDefaultBuilder: ComputerBuilder {
    
    private let computerID: Int
    
    init(computerID: Int) {
        self.computerID = computerID
    }
    
    func build() -> UIViewController {
        guard let viewController = UIStoryboard(name: "Computer", bundle: nil).instantiateViewController(withIdentifier: "ComputerViewController") as? ComputerViewController else {
            return ComputerViewController()
        }
        let router = CardDefaultRouter(viewController: viewController)
        viewController.cardRouter = router
        viewController.computerID = computerID
        return viewController
    }
}
