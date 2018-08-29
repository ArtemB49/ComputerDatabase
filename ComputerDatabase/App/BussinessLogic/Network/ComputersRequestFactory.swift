/**
 * Фабрика запросов компьютеров
 */

import Foundation
import Alamofire

protocol ComputersRequestFactory {
    
    func getListComputer(
        pageNumber: Int,
        completionHandler: @escaping (DataResponse<ListComputersResult>) -> Void
    )
    
    func getComputer(
        computerID: Int,
        completionHandler: @escaping (DataResponse<ComputerResult>) -> Void
    )
    
    func getSimilarComputer(
        computerID: Int,
        completionHandler: @escaping (DataResponse<[ComputerResult]>) -> Void
        )
}

