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
    
    
    func test_GetREcipes_Recipes() {
        
        let expectations = expectation(description: "Recipes searched")
        
        CookItAPI.shared.getRecipes(by: ("chinese","salad")) { (recipes, error) in
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
        
        waitForExpectations(timeout: 30, handler:nil)
        
    }
    
    func test_GetRecipe_Recipe() {
        
        let expectations = expectation(description: "Search Recipe")
        
        CookItAPI.shared.getRecipe(by: "156992") { (recipe, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return XCTFail("error returned")
            }
            
            guard let recipe = recipe else {
                return XCTFail("no recipes returned")
            }
            print(recipe)
            XCTAssert(true)
            expectations.fulfill()
        }
        
        waitForExpectations(timeout: 30, handler:nil)
    
    }
    
    func test_GetRecipeComplex_Recipes() {
        
        let expectations = expectation(description: "Search Recipe")
        
        let egg = Ingredient(name: "egg")
        let onion = Ingredient(name: "onion")
        
        Settings.shared.cuisine = ConstantsGeneral.Cuisine.american
        Settings.shared.type = ConstantsGeneral.TypeDish.mainCourse
        
        UserProfile.shared.includeIngredients = [egg,onion]
        
        CookItAPI.shared.getComplexRecipes { (recipe, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return XCTFail("error returned")
            }
            
            guard let recipe = recipe else {
                return XCTFail("no recipes returned")
            }
            print(recipe)
            XCTAssert(true)
            expectations.fulfill()
        }
        
        waitForExpectations(timeout: 180, handler:nil)
        
    }
    
    func test_GetIngredient_Ingredient() {
        
        let expectations = expectation(description: "Search Recipe")
        
        CookItAPI.shared.getIngredient(by: "gluten-free-veggie-burger-759739.jpg") { (image, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return XCTFail("error returned")
            }
            
            guard let image = image else {
                return XCTFail("no recipes returned")
            }
            print(image)
            XCTAssert(true)
            expectations.fulfill()
        }
        
        waitForExpectations(timeout: 30, handler:nil)
        
    }
    
    func test_GetImage_Image() {
        
        let expectations = expectation(description: "Search Image")
        
        CookItAPI.shared.getImage(by: "616564", with: ConstantsGeneral.ImageSize.xxs) { (image, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                return XCTFail("error returned")
            }
            
            guard let image = image else {
                return XCTFail("no recipes returned")
            }
            print(image)
            XCTAssert(true)
            expectations.fulfill()
        }
        
        waitForExpectations(timeout: 30, handler:nil)
        
    }
    
    
}
