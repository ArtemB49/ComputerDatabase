/**
 * Модель ответа сервера на Запрос данных списка компьютеров
 */

import Foundation


struct ListComputersResult: Codable {
    let currentPage: Int
    let offset: Int
    let total: Int
    let items: [ComputerResult]
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "page"
        case offset = "offset"
        case total = "total"
        case items = "items"
    }
}
