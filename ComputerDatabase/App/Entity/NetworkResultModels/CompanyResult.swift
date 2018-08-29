/**
 * Модель ответа сервера на Запрос производителей
 */

import Foundation

struct CompanyResult: Codable {
    let companyID: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case companyID = "id"
        case name = "name"
    }
}
