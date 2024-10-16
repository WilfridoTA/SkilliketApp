//
//  SkilliketTests.swift
//  SkilliketTests
//
//  Created by Astrea Polaris on 15/10/24.
//

import XCTest
@testable import Skilliket

var loginVC:LoginVC!

final class SkilliketTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testHU04_CP01_login_Success(){
        loginVC=LoginVC()
        
        DispatchQueue.main.async {
            loginVC.loadViewIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertNotNil(loginVC.passwordTextField)
                XCTAssertNotNil(loginVC.usernameTextField)
                            
                let validUserName = "ReginaM"
                let validPassword = "m0nt@ñ4R36"
                            
                loginVC.passwordTextField?.text = validUserName
                loginVC.usernameTextField?.text = validPassword
                            
                loginVC.loginButton.sendActions(for: .touchUpInside)
                            
                XCTAssertNotNil(loginVC.actualMember)
            }
        }
        

    }
    
    func testHU04_CP01_login_Fail(){
        loginVC=LoginVC()
        DispatchQueue.main.async {
            loginVC.loadViewIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertNotNil(loginVC.passwordTextField)
                XCTAssertNotNil(loginVC.usernameTextField)
                            
                let validUserName = "ReginaM"
                let invalidPassword = "contraseña"
                            
                loginVC.passwordTextField?.text = validUserName
                loginVC.usernameTextField?.text = invalidPassword
                            
                loginVC.loginButton.sendActions(for: .touchUpInside)
                            
                XCTAssertNil(loginVC.actualMember)
            }
        }
        
    }
    
    func testHU04_CP01_login_Fail2(){
        loginVC=LoginVC()
        DispatchQueue.main.async {
            loginVC.loadViewIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertNotNil(loginVC.passwordTextField)
                XCTAssertNotNil(loginVC.usernameTextField)
                            
                let invalidUserName = "usuario"
                let invalidPassword = "contraseña"
                            
                loginVC.passwordTextField?.text = invalidUserName
                loginVC.usernameTextField?.text = invalidPassword
                            
                loginVC.loginButton.sendActions(for: .touchUpInside)
                            
                XCTAssertNil(loginVC.actualMember)
            }
        }
        
    }
    
    func testHU01_CP02_register_Success(){
        var registerVC=CreateAccountVC()
        var loginVC=LoginVC()
        DispatchQueue.main.async {
            registerVC.loadViewIfNeeded()
            loginVC.loadViewIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertNotNil(loginVC.passwordTextField)
                XCTAssertNotNil(loginVC.usernameTextField)
                XCTAssertNotNil(registerVC.passwordTextField)
                XCTAssertNotNil(registerVC.usernameTextField)
                XCTAssertNotNil(registerVC.nameTextField)
                XCTAssertNotNil(registerVC.lastNameTextField)
                XCTAssertNotNil(registerVC.emailTextField)
                XCTAssertNotNil(registerVC.agreeTermsButton)
                XCTAssertNotNil(registerVC.eulaButton)
                
                            
                let validUsername = "usuario"
                let validPassword = "Contraseña_123"
                let validMail="usuario@gmail.com"
                let validName="Nombre"
                let validLastName="Last Name"
                            
                registerVC.passwordTextField.text=validPassword
                registerVC.nameTextField.text=validName
                registerVC.lastNameTextField.text=validLastName
                registerVC.usernameTextField.text=validUsername
                registerVC.emailTextField.text=validMail
                registerVC.ourApp=loginVC.ourApp
                
                registerVC.agreeTermsButton.sendActions(for: .touchUpInside)
                registerVC.eulaButton.sendActions(for: .touchUpInside)
                                            
                XCTAssertTrue(registerVC.verifyAll())
            }
        }
    }
    
    func testHU01_CP02_register_Fail(){
        var registerVC=CreateAccountVC()
        var loginVC=LoginVC()
        DispatchQueue.main.async {
            registerVC.loadViewIfNeeded()
            loginVC.loadViewIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertNotNil(loginVC.passwordTextField)
                XCTAssertNotNil(loginVC.usernameTextField)
                XCTAssertNotNil(registerVC.passwordTextField)
                XCTAssertNotNil(registerVC.usernameTextField)
                XCTAssertNotNil(registerVC.nameTextField)
                XCTAssertNotNil(registerVC.lastNameTextField)
                XCTAssertNotNil(registerVC.emailTextField)
                XCTAssertNotNil(registerVC.agreeTermsButton)
                XCTAssertNotNil(registerVC.eulaButton)
                
                            
                let invalidUsername = "ReginaM"
                let validPassword = "Contraseña_123"
                let validMail="usuario@gmail.com"
                let validName="Nombre"
                let validLastName="Last Name"
                            
                registerVC.passwordTextField.text=validPassword
                registerVC.nameTextField.text=validName
                registerVC.lastNameTextField.text=validLastName
                registerVC.usernameTextField.text=invalidUsername
                registerVC.emailTextField.text=validMail
                registerVC.ourApp=loginVC.ourApp
                
                registerVC.agreeTermsButton.sendActions(for: .touchUpInside)
                registerVC.eulaButton.sendActions(for: .touchUpInside)
                                            
                XCTAssertFalse(registerVC.verifyAll())
            }
        }
    }
    
    func testHU01_CP02_register_Fail2(){
        var registerVC=CreateAccountVC()
        var loginVC=LoginVC()
        DispatchQueue.main.async {
            registerVC.loadViewIfNeeded()
            loginVC.loadViewIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertNotNil(loginVC.passwordTextField)
                XCTAssertNotNil(loginVC.usernameTextField)
                XCTAssertNotNil(registerVC.passwordTextField)
                XCTAssertNotNil(registerVC.usernameTextField)
                XCTAssertNotNil(registerVC.nameTextField)
                XCTAssertNotNil(registerVC.lastNameTextField)
                XCTAssertNotNil(registerVC.emailTextField)
                XCTAssertNotNil(registerVC.agreeTermsButton)
                XCTAssertNotNil(registerVC.eulaButton)
                
                            
                let validUsername = "user"
                let invalidPassword = "cont"
                let validMail="usuario@gmail.com"
                let validName="Nombre"
                let validLastName="Last Name"
                            
                registerVC.passwordTextField.text=invalidPassword
                registerVC.nameTextField.text=validName
                registerVC.lastNameTextField.text=validLastName
                registerVC.usernameTextField.text=validUsername
                registerVC.emailTextField.text=validMail
                registerVC.ourApp=loginVC.ourApp
                
                registerVC.agreeTermsButton.sendActions(for: .touchUpInside)
                registerVC.eulaButton.sendActions(for: .touchUpInside)
                                            
                XCTAssertFalse(registerVC.verifyAll())
            }
        }
    }
    
    func testHU01_CP02_register_Fail3(){
        var registerVC=CreateAccountVC()
        var loginVC=LoginVC()
        DispatchQueue.main.async {
            registerVC.loadViewIfNeeded()
            loginVC.loadViewIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertNotNil(loginVC.passwordTextField)
                XCTAssertNotNil(loginVC.usernameTextField)
                XCTAssertNotNil(registerVC.passwordTextField)
                XCTAssertNotNil(registerVC.usernameTextField)
                XCTAssertNotNil(registerVC.nameTextField)
                XCTAssertNotNil(registerVC.lastNameTextField)
                XCTAssertNotNil(registerVC.emailTextField)
                XCTAssertNotNil(registerVC.agreeTermsButton)
                XCTAssertNotNil(registerVC.eulaButton)
                
                            
                let validUsername = "user"
                let validPassword = "contraseña-123"
                let invalidMail="correo"
                let validName="Nombre"
                let validLastName="Last Name"
                            
                registerVC.passwordTextField.text=validPassword
                registerVC.nameTextField.text=validName
                registerVC.lastNameTextField.text=validLastName
                registerVC.usernameTextField.text=validUsername
                registerVC.emailTextField.text=invalidMail
                registerVC.ourApp=loginVC.ourApp
                
                registerVC.agreeTermsButton.sendActions(for: .touchUpInside)
                registerVC.eulaButton.sendActions(for: .touchUpInside)
                                            
                XCTAssertFalse(registerVC.verifyAll())
            }
        }
    }
    
    func testHU02_CP03_seeTermsAndConditions_Success() {
        let loginVC = LoginVC()
        
        DispatchQueue.main.async {
            loginVC.loadViewIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                XCTAssertNotNil(loginVC.passwordTextField)
                XCTAssertNotNil(loginVC.usernameTextField)
                            
                loginVC.privacyNoticeButton?.sendActions(for: .touchUpInside)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let presentedVC = loginVC.presentedViewController
                    XCTAssertNotNil(presentedVC)
                    XCTAssertTrue(presentedVC is ShowTermsConditionsViewController)
                    
                }
            }
        }
    }
    
    
    func testHU02_CP04_agreeTerms_Success(){
        var registerVC=CreateAccountVC()
        var loginVC=LoginVC()
        DispatchQueue.main.async {
            registerVC.loadViewIfNeeded()
            loginVC.loadViewIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertNotNil(loginVC.passwordTextField)
                XCTAssertNotNil(loginVC.usernameTextField)
                XCTAssertNotNil(registerVC.passwordTextField)
                XCTAssertNotNil(registerVC.usernameTextField)
                XCTAssertNotNil(registerVC.nameTextField)
                XCTAssertNotNil(registerVC.lastNameTextField)
                XCTAssertNotNil(registerVC.emailTextField)
                XCTAssertNotNil(registerVC.agreeTermsButton)
                XCTAssertNotNil(registerVC.eulaButton)
                
                registerVC.agreeTermsButton.sendActions(for: .touchUpInside)
                
                XCTAssertTrue(registerVC.agreeTerms)

            }
        }
    }
    
    func testHU07_CP05_createPost_Success(){
        let createContentViewController = CreateContentViewController()
        
        DispatchQueue.main.async {
            createContentViewController.loadViewIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            
                createContentViewController.postButton.sendActions(for: .touchUpInside)

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    let presentedVC = loginVC.presentedViewController
                    XCTAssertNotNil(presentedVC)
                    XCTAssertTrue(presentedVC is ShowTermsConditionsViewController)
                    
                }
            }
        }
        
        
    }
    


}
