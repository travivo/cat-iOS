//
//  CatViewModelNegativeTests.swift
//  CatsTests
//
//  Created by aljon antiola on 10/13/24.
//

import XCTest
@testable import Cats

final class CatViewModelNegativeTests: XCTestCase {
    
    var viewModel: CatViewModel!
    
    override func setUpWithError() throws {
        viewModel = CatViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    // Negative Test: Checks behavior when an invalid image URL is provided.
    func testLoadImageWithInvalidURL() {
        let invalidImageUrlString = "invalid_url_string"
        guard let invalidImageUrl = URL(string: invalidImageUrlString) else {
            XCTFail("Invalid URL")
            return
        }
        
        let expectation = self.expectation(description: "Load image with invalid URL")
        
        viewModel.loadImage(from: invalidImageUrl) { image in
            XCTAssertNil(image, "Image should be nil when loading from an invalid URL")
            XCTAssertNil(self.viewModel.imageCache[invalidImageUrlString], "Image should not be cached for an invalid URL")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
