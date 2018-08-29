/**
* Фабрика запросов
*/

import Foundation
import Alamofire
@testable import ComputerDatabase

class RequestFactoryTest {
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let manager = SessionManager(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeComputersRequestFactory<T>() -> T! {
        let errorParser = makeErrorParser()
        return ComputersRequestFactoryImpl(
            errorParser: errorParser,
            sessionManager: commonSessionManager,
            queue: sessionQueue) as? T
    }
}
