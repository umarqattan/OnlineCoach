//
//  OnlineCoachUITests.swift
//  OnlineCoachUITests
//
//  Created by Umar Qattan on 7/18/17.
//  Copyright © 2017 Umar Qattan. All rights reserved.
//

import XCTest

class OnlineCoachUITests: XCTestCase {
    
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    
    }
    
    func testLaunchPage() {
        app.launch()
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
       
        // Launch the app
        app.launch()
        
        // Test if the loginButton exists on the 
        // LoginViewCOntroller
        XCTAssert(app.buttons["loginButton"].exists)
        
        // Tap the loginButton
        app.buttons["loginButton"].tap()
        
        // Indicates that we have arrived at the next
        // UIViewController
        XCTAssertFalse(app.buttons["loginButton"].exists)
        
        
        
    }
    
    func testNewUser() {
        
        
        app.launch()
        
        XCTAssert(app.buttons["registerHereButton"].exists)
        
        app.buttons["registerHereButton"].tap()
        
        XCTAssertFalse(app.buttons["registerHereButton"].exists)
        
        XCTAssert(app.textFields["firstNameField"].exists)
        XCTAssert(app.textFields["lastNameField"].exists)
        XCTAssert(app.textFields["emailAddressField"].exists)
        XCTAssert(app.textFields["phoneNumberField"].exists)
        XCTAssert(app.switches["roleSwitch"].exists)
        
        app.textFields["firstNameField"].tap()
        app.textFields["firstNameField"].setText(text: "Umar", application: app)
        
        app.textFields["lastNameField"].tap()
        app.textFields["lastNameField"].setText(text: "Qattan", application: app)
        
        app.textFields["emailAddressField"].tap()
        app.textFields["emailAddressField"].setText(text: "u.qattan@gmail.com", application: app)
        
        app.textFields["phoneNumberField"].tap()
        app.textFields["phoneNumberField"].setText(text: "8053124900", application: app)
        
        app.switches["roleSwitch"].tap()
        app.buttons["nextButton"].tap()
        
        
        // Check if left the UserInformationViewController
        //XCTAssertFalse(app.buttons["nextButton"].exists)

        
        // Check if all the XCUIElements of the BodyInformationViewController exist
        
        XCTAssert(app.textFields["heightField"].exists)
        XCTAssert(app.textFields["weightField"].exists)
        XCTAssert(app.textFields["ageField"].exists)
        
        XCTAssert(app.switches["unitSwitch"].exists)
        XCTAssert(app.staticTexts["heightUnitLabel"].exists)
        XCTAssert(app.staticTexts["weightUnitLabel"].exists)
        
        
        // Start populating fields in the BodyInformationViewController
        
        app.textFields["heightField"].tap()
        app.textFields["heightField"].setText(text: "72", application: app)
        
        app.textFields["weightField"].tap()
        app.textFields["weightField"].setText(text: "163.5", application: app)
        
        app.textFields["ageField"].tap()
        
        app.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "September")
        app.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "10")
        app.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "1994")
        
        
        app.buttons["doneButton"].tap()
        
        app.switches["unitSwitch"].tap()
        
        app.buttons["nextButton"].tap()
        
        
        // Check if left the BodyInformationViewController

        //XCTAssertFalse(app.buttons["nextButton"].exists)
        
        XCTAssert(app.segmentedControls["goalControl"].exists)
        
        app.segmentedControls.buttons.element(boundBy: 1).tap()
        
        XCTAssert(app.segmentedControls["goalControl"].buttons.element(boundBy: 1).isSelected)
        
        app.buttons["nextButton"].tap()
        
        // YOU REGISTERED
        XCTAssert(app.staticTexts["youRegisteredLabel"].exists)
    
        
        
        
        
        
    }
    
    
    
}


extension XCUIApplication {
    var isDisplayingLoginButton: Bool {
        return otherElements["loginButton"].exists
    }
}

extension XCUIElement {
    
    func setText(text: String, application: XCUIApplication) {
        UIPasteboard.general.string = text
        doubleTap()
        application.menuItems["Paste"].tap()
    }
}
