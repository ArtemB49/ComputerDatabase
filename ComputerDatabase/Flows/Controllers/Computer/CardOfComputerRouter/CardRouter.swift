/**
 * Роутер отображения интерфейса контроллера компьютера
 */

import Foundation

protocol CardRouter {
    func makeCard(computer: Computer)
    func makeSimilarButtons(computers: [ComputerResult])
}
