/**
 * Тестирование запросов
 */

import Foundation
import XCTest
import Alamofire
@testable import ComputerDatabase

class ComputersRequestFactoryTests: XCTestCase {
    
    
    var computersRequests: ComputersRequestFactory?
    var errorParser: ErrorParserStubs!
    
    override func setUp() {
        super.setUp()
        computersRequests = RequestFactoryTest().makeComputersRequestFactory()
        errorParser = ErrorParserStubs()
    }
    
    override func tearDown() {
        super.tearDown()
        computersRequests = nil
        errorParser = nil
    }
    
    func testListComputers() {
        let exp = expectation(description: "")
        var listComputersResult: ListComputersResult?
        
        computersRequests?.getListComputer(pageNumber: 1) {
            (response: DataResponse<ListComputersResult>) in
            
            listComputersResult = response.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
        XCTAssertNotNil(listComputersResult)
    }
    
    func testComputer() {
        let exp = expectation(description: "")
        var computer: ComputerResult?
        
        computersRequests?.getComputer(computerID: 1){
            (response: DataResponse<ComputerResult>) in
            
            computer = response.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
        XCTAssertNotNil(computer)
    }
    
    func testSimilarComputers() {
        let exp = expectation(description: "")
        var listComputers: [ComputerResult]?
        
        computersRequests?.getSimilarComputer(computerID: 1) {
            (response: DataResponse<[ComputerResult]>) in
            
            listComputers = response.value
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
        XCTAssertNotNil(listComputers)
    }
}
