//
//  CalculateTest.swift
//  CountOnMeTests
//
//  Created by Thomas Bouges on 2019-01-31.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import XCTest

@testable import CountOnMe

class CalculateTest: XCTestCase {
    
    var calculate: Calculate!
    
    //override new calculate for each test
    override func setUp() {
        super.setUp()
        calculate = Calculate()
    }

    // MARK: - Methods
    // LOGIC that simulate tap on button and control if total of operation is correct
    func addNewOperation(number : String, total : String){
        //given
        var temporyVar :String = "total"
        for char in number {
            
            if char == "."{
             temporyVar = calculate.addDot()
            }else if char == "+" || char == "-" || char == "x" || char == "/" {
              temporyVar =  calculate.addNewOperator(String(char))
            }else if char == "="{
                temporyVar = calculate.calculateTotal()
             }else{
               temporyVar =  calculate.addNewNumber(Int(String(char))!)
            }
            
        }
        XCTAssert(temporyVar == total)
    }
    
    // LOGIC that simulate tap on button but return Boolean, done in order to control alert
    func controlAlert(number : String) -> Bool{
        
        var temporyVar :String = "test"
        for char in number {
            switch char {
                case "." :
                    temporyVar = calculate.addDot()
                    if temporyVar == ""{
                        return false
                    }
                case "+","-","x","/":
                    temporyVar =  calculate.addNewOperator(String(char))
                    if temporyVar == ""{
                        return false
                    }
                case "=":
                    temporyVar = calculate.calculateTotal()
                    if temporyVar == "0.0"{  //divide by Zero
                        return false
                    }else  if temporyVar == ""{ // wrong expression start =
                        return false
                }
                default :
                    temporyVar =  calculate.addNewNumber(Int(String(char))!) // test all is alright
            }
          
        }
        return true
    }
    
    
    // MARK: - Test Operation and Result
    
    //test 1+1 =2
    func testTotalValueIsZero_WhenIncrementingPlusOperation_ThenTotalValueIsTwo(){
        addNewOperation(number: "1+1=",  total: "2.0")
    }
    
    //test 1-1=0
    func testTotalValueIsZero_WhenIncrementingMenusOperation_ThenTotalValueIs0(){
        addNewOperation(number: "1.02-1.02=",  total: "0.0")
    }
    
    // Test 1x2=2
    func testTotalValueIsZero_WhenIncrementingMutiplicationOperation_ThenTotalValueIsTwo(){
        addNewOperation(number: "1x2=",  total: "2.0")
    }
     // Test 6/2=3
    func testTotalValueIsZero_WhenIncrementingDivisionOperation_ThenTotalValueIsThree(){
        addNewOperation(number: "6/2=",  total: "3.0")
    }
    
    // Test 6/2x3=9
    func testTotalValueIsZero_WhenIncrementingDivisionMultiplicationOperation_ThenTotalValueIsNine(){
        addNewOperation(number: "6/2x3=",  total: "9.0")
    }
    
    //Test 2+2x2=6
    func testTotalValueIsZero_WhenIncrementingPlusMultiplicationOperation_ThenTotalValueIsSix(){
        addNewOperation(number: "2+2x2=",  total: "6.0")
    }
    
    //test 2-2x9=-16
    func testTotalValueIsZero_WhenIncrementingMenosAndMultiplicationOperation_ThenTotalValueIsSixteen(){
        addNewOperation(number: "2-2x9=",  total: "-16.0")
    }
    
    // Test 10/2+2x2=9
    func testTotalValueIsZero_WhenIncrementingDivisionPlusMultiplicationOperation_ThenTotalValueIsNine(){
        addNewOperation(number: "10/2+2x2=", total: "9.0")
    }
    
    // MARK: - Test clear
    //Test that control that all properties are erased before to start a new operation
    func testClear(){
        
        addNewOperation(number:  "10/2+2x2=", total: "9.0")
       
        addNewOperation(number:  "10/2+2x2=", total: "9.0")
        
    }
    
    // MARK: - Test of Error Alert
    // test error no figure +
    func testNoFigureEnteredAlert(){
        
        XCTAssertFalse(controlAlert(number: "=" ))
    }
    
    // test error no figure +
    func testOperatorFollowingOfEqualAlert(){
        
        XCTAssertFalse(controlAlert(number: "2x2-=" ))
    }
    
    // test error on double . 10.2.9
    func testDoubleDotErrorAlert(){
        XCTAssertFalse(controlAlert(number: "10.2.9/2+2x2" ))
    }
    
    // test error on dot withour figure before 10.2-.2
    func testDoubleDotErrorAlert2(){
        XCTAssertFalse(controlAlert(number: "10.2-.2" ))
    }
    
    // test error on double . +10.
    func testDoubleOperatorAlert(){
        
        XCTAssertFalse(controlAlert(number: "+10.2/2+2x2" ))
    }
    
    // test error on double . 10.2/x2
    func testDoubleOperator2Alert(){
        
        XCTAssertFalse(controlAlert(number: "10.2/x2+2x2" ))
    }
    
    // test error on double . 10.2/0
    func testDividedbyZeroAlert(){
        
        XCTAssertFalse(controlAlert(number: "10.2/0+2x2=" ))
    }
    
    
}
