/**
 * Модель ответа сервера на Запрос компьютера
 */

import Foundation

struct ComputerResult: Codable{
    let computerID: Int
    let name: String
    let introduced: Date?
    let discounted: Date?
    let imageUrl: URL?
    let company: CompanyResult?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case computerID = "id"
        case name = "name"
        case introduced
        case discounted
        case imageUrl
        case company
        case description
    }
}

extension ComputerResult {
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        computerID = try container.decode(Int.self, forKey: .computerID)
        name = try container.decode(String.self, forKey: .name)
        imageUrl = try? container.decode(URL.self, forKey: .imageUrl)
        description = try? container.decode(String.self, forKey: .description)
        company = try? container.decode(CompanyResult.self, forKey: .company)
        
        let introducedString = try? container.decode(String.self, forKey: .discounted)
        let formatter = DateFormatter.iso8601Full
        if let dateString = introducedString,
            let date = formatter.date(from: dateString) {
            introduced = date
        } else {
            introduced = nil
        }
        let discountedString = try? container.decode(String.self, forKey: .discounted)
        if let dateString = discountedString,
            let date = formatter.date(from: dateString) {
            discounted = date
        } else {
            discounted = nil
        }
    }
    
    func decodeDate(container: KeyedDecodingContainer<CodingKeys>, key: CodingKeys) throws -> Date? {
        let dateString = try? container.decode(String.self, forKey: key)
        
        let formatter = DateFormatter.iso8601Full
        if let dateString = dateString,
            let date = formatter.date(from: dateString) {
            return date
        } else {
            throw DecodingError.dataCorruptedError(
                forKey: .introduced,
                in: container,
                debugDescription: "Date string does not match format expected by formatter."
            )
        }
    }
}
