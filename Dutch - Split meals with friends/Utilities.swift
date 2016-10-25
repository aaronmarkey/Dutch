//
//  Utilities.swift
//  Dutch - Split meals with friends
//
//  Created by Aaron Markey on 10/9/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit

/*
 Shows alert message
 
 - Parameter errorMessage: The message to show in the error.
 - Parameter view: The view to display this alert on top of.
 */
func createAndDisplayErrorAlert(_ errorMessage: String, view: UIViewController) {
    
    //create alert conrtroller
    let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
    
    //set cancel button title
    let cancelButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    
    //add button to alert controller
    alertController.addAction(cancelButton)
    
    //present the controller
    view.present(alertController, animated: true, completion: nil)
}

/*
 - Parameter sliderValue: A value given from the tipPercentageSlider.
 
 - Returns: sliderValue * 5.
 */
func calculateTipPercentage(_ sliderValue: Int) -> Int {
    return sliderValue * 5
}

/*
 - Parameter net: The net bill amount.
 - Parameter tip: The dollar amount of the tip.
 
 - Returns: The gross amount of the bill.
 */
func calculateTotalBill(_ net: Double, tip: Double) -> Double {
    return net + tip
}

/*
 - Parameter total: The gross bill amount.
 - Parameter numPeople: The number of people to spilt the bill amoungst.
 
 - Returns: How much each person should pay.
 */
func calculateCostPerPerson(_ total: Double, numPeople: Int) -> Double {
    return total / Double(numPeople)
}

/*
 - Parameter total: The net bill amount.
 - Parameter tip: The amount of the tip as a percentage of 100, ex: 20, 54
 
 - Returns: The amount the tip equates to.
 */
func calculateTipAmount(_ total: Double, tip: Int) -> Double {
    return total * (Double(tip) / 100.00)
}

/*  
 Formats a number for output on screen
 
 - Parameter number: The number to be formatted.
 - Parameter style: The style to apply to number.

 - Returns: The formatted number as a String.
*/
func formatNumber(_ number: NSNumber, style: NumberFormatter.Style) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = style
    return formatter.string(from: number)!
}
