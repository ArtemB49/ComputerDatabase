/**
* Фабрика запросов
*/

import Foundation
import Alamofire

class RequestFactory {
    private func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    private lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let manager = SessionManager(configuration: configuration)
        return manager
    }()
    
    private let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeComputersRequestFactory() -> ComputersRequestFactory {
        let errorParser = makeErrorParser()
        return ComputersRequestFactoryImpl(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue)
    }
}
