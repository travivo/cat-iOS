//
//  CatViewModelTests.swift
//  CatsTests
//
//  Created by aljon antiola on 10/13/24.
//

import XCTest
@testable import Cats

final class CatViewModelTests: XCTestCase {

    var viewModel: CatViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = CatViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    // This test ensures that the `fetchCatData` method fetches both cat facts and image URLs without errors.
    // The test will wait for the async call to complete and verify that neither `catFacts` nor `catImageUrls` are empty.
    func testFetchCatData() {
        // Set up an expectation to wait for the async method to complete.
        let expectation = self.expectation(description: "Fetch Cat Data")
        
        viewModel.fetchCatData { error in
            XCTAssertNil(error, "There should be no error")
            XCTAssertFalse(self.viewModel.catFacts.isEmpty, "Cat facts should not be empty")
            XCTAssertFalse(self.viewModel.catImageUrls.isEmpty, "Cat image URLs should not be empty")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // This test checks that the `getNextImageUrl` function correctly returns the next image URL from the list.
    // It also verifies that advancing the image index works as expected.
    func testGetNextImageUrl() {
        viewModel.catImageUrls = ["url1", "url2", "url3"].map { CatImage(url: $0) }
        
        let firstUrl = viewModel.getNextImageUrl()
        XCTAssertEqual(firstUrl, "url1", "First URL should match")
        
        viewModel.advanceToNextImage()
        let secondUrl = viewModel.getNextImageUrl()
        XCTAssertEqual(secondUrl, "url2", "Second URL should match")
    }
    
    
    // This test verifies the functionality of loading images and caching them.
    // It first loads an image from a URL and checks that the image is not nil.
    // It then confirms that the image is cached by checking the cache.
    func testLoadImageWithCaching() {

        // Use a sample URL that points to a valid image
        let imageUrlString = "https://cdn2.thecatapi.com/images/6ua.jpg"
        guard let imageUrl = URL(string: imageUrlString) else {
            XCTFail("Invalid URL")
            return
        }
        
        let expectation = self.expectation(description: "Load image with caching")
        
        // Load the image for the first time
        viewModel.loadImage(from: imageUrl) { [self] image in
            XCTAssertNotNil(image, "Image should be loaded")
            
            // Check if the image is cached
            XCTAssertNotNil(viewModel.imageCache[imageUrlString], "Image should be cached after loading")
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
