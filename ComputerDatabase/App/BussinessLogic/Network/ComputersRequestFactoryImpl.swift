/**
 * Реализаци фабрики получения компьютеров и компаний
 */

import Foundation
import Alamofire

class ComputersRequestFactoryImpl: BaseRequestFactory, ComputersRequestFactory {
    func getListComputer(pageNumber: Int, completionHandler: @escaping (DataResponse<ListComputersResult>) -> Void) {
        let requestModel = ListComputersRequestModel(baseUrl: baseUrl, pageNumber: pageNumber)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getComputer(computerID: Int, completionHandler: @escaping (DataResponse<ComputerResult>) -> Void) {
        let requestModel = ComputerRequestModel(baseUrl: baseUrl, computerID: computerID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func getSimilarComputer(computerID: Int, completionHandler: @escaping (DataResponse<[ComputerResult]>) -> Void) {
        let requestModel = SimilarComputerRequestModel(baseUrl: baseUrl, computerID: computerID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ComputersRequestFactoryImpl {
    struct ListComputersRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let pageNumber: Int
        let path: String = "rest/computers"
        
        var parameters: Parameters? {
            return [
                "p": pageNumber
            ]
        }
    }
}

extension ComputersRequestFactoryImpl {
    struct ComputerRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let computerID: Int
        var path: String {
            return "rest/computers/\(computerID)"
        }
        
        var parameters: Parameters? {
            return nil
        }
    }
}

extension ComputersRequestFactoryImpl {
    struct SimilarComputerRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let computerID: Int
        var path: String {
            return "rest/computers/\(computerID)/similar"
        }
        
        var parameters: Parameters? {
            return nil
        }
    }
}
