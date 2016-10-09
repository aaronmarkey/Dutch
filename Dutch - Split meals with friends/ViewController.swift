//
//  ViewController.swift
//  Dutch - Split meals with friends
//
//  Created by Aaron Markey on 10/7/16.
//  Copyright © 2016 Aaron Markey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    var billAmount = 0.0 {
        didSet {
            configureView()
        }
    }
    var tipAmountScalar = 4 {
        didSet {
            configureView()
        }
    }
    var numPeople = 1 {
        didSet {
            configureView()
        }
    }
    var errorMessage = ""
    
    
    //MARK: Outlets
    @IBOutlet weak var totalAmountDisplay: UILabel!
    @IBOutlet weak var tipAmountDisplay: UILabel!
    @IBOutlet weak var perPersonAmountDisplay: UILabel!
    @IBOutlet weak var tipPercentageDisplay: UILabel!
    @IBOutlet weak var numPeopleDisplay: UILabel!
    

    //MARK: Actions
    @IBAction func tipSlider(sender: UISlider) {
        tipAmountScalar = Int(sender.value)
    }
    
    @IBAction func numPeopleSlider(sender: UISlider) {
        numPeople = Int(sender.value)
    }
    
    @IBAction func billAmountField(sender: UITextField) {
        let input = sender.text?.stringByReplacingOccurrencesOfString(" ", withString: "")
        if input == "" {
            billAmount = 0.00
        } else {
            if let value = Double(input!) {
                if(value >= 0) {
                    billAmount = value
                } else {
                    createAndDisplayErrorAlert(errorMessage, view: self)
                }
            } else {
                createAndDisplayErrorAlert(errorMessage, view: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get dictionary of  values from custom plist
        let path = NSBundle.mainBundle().pathForResource("custom", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        //set default values
        billAmount = dict!.objectForKey("defaultBillAmount") as! Double
        numPeople = dict!.objectForKey("defaultNumPeople") as! Int
        tipAmountScalar = dict!.objectForKey("defaultTipPercentage") as! Int
        errorMessage = dict!.objectForKey("defaultErrorMessage") as! String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .All
    }
    
    //MARK: UIResponder functions
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextView) -> Bool {
        textField.resignFirstResponder();
        return true
    }
    
    /*
     Calculate needed values and update display
     */
    func configureView() {
        
        //calculate values
        let tipPercentage = calculateTipPercentage(tipAmountScalar)
        let tipAmount = calculateTipAmount(billAmount, tip: tipPercentage)
        let totalBillAmount = calculateTotalBill(billAmount, tip: tipAmount)
        let costPerPerson = calculateCostPerPerson(totalBillAmount, numPeople: numPeople)
        
        //update display with value
        tipPercentageDisplay.text = "\(tipPercentage)%"
        numPeopleDisplay.text = "\(numPeople)"
        perPersonAmountDisplay.text = formatNumber(NSNumber(double: costPerPerson), style: .CurrencyStyle)
        tipAmountDisplay.text = formatNumber(NSNumber(double: tipAmount), style: .CurrencyStyle)
        totalAmountDisplay.text = formatNumber(NSNumber(double: totalBillAmount), style: .CurrencyStyle)
    }

}

