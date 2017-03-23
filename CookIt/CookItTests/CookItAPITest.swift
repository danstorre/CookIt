//
//  CookItAPITest.swift
//  CookIt
//
//  Created by Daniel Torres on 3/23/17.
//  Copyright © 2017 Danieltorres. All rights reserved.
//

import XCTest
@testable import CookIt

class CookItAPITest: XCTestCase {
    
    
    func test_GetSessionID_SessionID() {
        
        let cookItAPI = CookItAPI()
        let expectations = expectation(description: "Recipes searched")
        
        cookItAPI.getRecipes(by: ("chinese","salad")) { (recipes, error) in
            guard error == nil else {
                
                print(error!.localizedDescription)
                return XCTFail("error returned")
            }
            
            guard let recipes = recipes else {
                return XCTFail("no recipes returned")
            }
            print(recipes)
            XCTAssert(true)
            expectations.fulfill()
            
        }
        
        waitForExpectations(timeout: 60.0, handler:nil)
        
    }
    
}
