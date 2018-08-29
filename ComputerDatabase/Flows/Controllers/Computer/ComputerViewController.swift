/**
 * Контроллер компьютера
 */

import UIKit
import SnapKit

class ComputerViewController: UIViewController {
    
    // MARK: - Private properties
    private let context = CoreDataStack.shared.makePrivateContext()
    private var computerRequestFactory = RequestFactory().makeComputersRequestFactory()
    
    // MARK: - Public properties
    var cardRouter: CardRouter!
    
    var computerID: Int? {
        willSet(newValue) {
            
            ComputerRepository.shared.fetchComputer(computerID: Int16(newValue!)) { computer in
                self.showCard(computer: computer)
                self.downloadSimilar(computerID: Int(computer.computerID))
            }
        }
    }

    
    // MARK: - Private methods
    private func downloadSimilar(computerID: Int) {
        
        computerRequestFactory
            .getSimilarComputer(computerID: computerID) { response in
            switch response.result {
            case .success(let computers):
                self.showSimilar(computers: computers)
            case .failure(let error):
                print("--- Error: \(error) ---")
            }
        }
    }
    
    private func showCard(computer: Computer) {
        DispatchQueue.main.async {
            self.title = computer.name
            self.cardRouter.makeCard(computer: computer)
        }
    }
    
    private func showSimilar(computers: [ComputerResult]) {
        DispatchQueue.main.async {
            self.cardRouter.makeSimilarButtons(computers: computers)
        }
        
    }
}
