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
    @IBAction func tipSlider(_ sender: UISlider) {
        tipAmountScalar = Int(sender.value)
    }
    
    @IBAction func numPeopleSlider(_ sender: UISlider) {
        numPeople = Int(sender.value)
    }
    
    @IBAction func billAmountField(_ sender: UITextField) {
        let input = sender.text?.replacingOccurrences(of: " ", with: "")
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
        let path = Bundle.main.path(forResource: "custom", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!)
        
        //set default values
        billAmount = dict!.object(forKey: "defaultBillAmount") as! Double
        numPeople = dict!.object(forKey: "defaultNumPeople") as! Int
        tipAmountScalar = dict!.object(forKey: "defaultTipPercentage") as! Int
        errorMessage = dict!.object(forKey: "defaultErrorMessage") as! String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .all
    }
    
    //MARK: UIResponder functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextView) -> Bool {
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
        perPersonAmountDisplay.text = formatNumber(NSNumber(value: costPerPerson as Double), style: .currency)
        tipAmountDisplay.text = formatNumber(NSNumber(value: tipAmount as Double), style: .currency)
        totalAmountDisplay.text = formatNumber(NSNumber(value: totalBillAmount as Double), style: .currency)
    }

}

