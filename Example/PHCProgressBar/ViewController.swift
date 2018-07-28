//
//  ViewController.swift
//  PHCProgressBar
//
//  Created by scottphc on 06/28/2018.
//  Copyright (c) 2018 scottphc. All rights reserved.
//

import UIKit
import PHCProgressBar

class ViewController: UIViewController {

    @IBOutlet weak var progressBar: PHCProgressBar! {
        didSet {
            progressBar.addTarget(self, action: #selector(clickAction), for: .touchUpInside)

            progressBar.layer.shadowColor = UIColor.black.cgColor
            progressBar.layer.shadowOffset = CGSize(width: 2, height: 2)
            progressBar.layer.shadowOpacity = 0.8
            progressBar.layer.masksToBounds = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc
    func clickAction() {
        print("Clicked")
    }

    // MARK: IBOutlet Events

    @IBAction func tapBackground(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func sliderValueChanged(_ slider: UISlider) {
        progressBar.progress = slider.value
    }

    @IBAction func topTextChanged(_ textField: UITextField) {
        progressBar.topText = textField.text
    }

    @IBAction func bottomTextChanged(_ textField: UITextField) {
        progressBar.bottomText = textField.text
    }

    @IBAction func circleTextChanged(_ textField: UITextField) {
        progressBar.circleText = textField.text
    }

    @IBAction func circleBackgroundColorChanged(_ textField: UITextField) {
        progressBar.circleBackgroundColor = UIColor(hexString: textField.text ?? "")
    }

    @IBAction func circleBorderColorChanged(_ textField: UITextField) {
        progressBar.circleBorderColor = UIColor(hexString: textField.text ?? "")
    }

    @IBAction func barBackgroundColorChanged(_ textField: UITextField) {
        progressBar.barBackgroundColor = UIColor(hexString: textField.text ?? "")
    }

    @IBAction func barBorderColorChanged(_ textField: UITextField) {
        progressBar.barBorderColor = UIColor(hexString: textField.text ?? "")
    }
    
    @IBAction func topTextColorChanged(_ textField: UITextField) {
        progressBar.topTextColor = UIColor(hexString: textField.text ?? "")
    }

    @IBAction func bottomTextColorChanged(_ textField: UITextField) {
        progressBar.bottomTextColor = UIColor(hexString: textField.text ?? "")
    }
    
    @IBAction func progressColorChanged(_ textField: UITextField) {
        progressBar.progressTintColor = UIColor(hexString: textField.text ?? "")
    }
}

