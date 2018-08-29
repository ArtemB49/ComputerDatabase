/**
 * Ошибки парсинга тестирование
 */

import Foundation
@testable import ComputerDatabase

enum ApiErrorStub: Error {
    case fatalError
}

struct ErrorParserStubs: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
    
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}
