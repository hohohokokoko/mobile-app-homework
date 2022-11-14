//
//  InformationViewController.swift
//  ECE564_HW
//
//  Created by 曹畅 on 2021/9/8.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit
import AVFoundation

// extensiono for compress image
public extension UIImage {
    func copy(newSize: CGSize, retina: Bool = true) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            /* size: */ newSize,
            /* opaque: */ false,
            /* scale: */ retina ? 0 : 1
        )
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

class InformationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var fromCell: Bool = false
    var keepImage: Bool = false
        
//    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 375, height: 40))
    
    let firstNameLabel = UILabel(frame: CGRect(x:25, y:60, width:100, height:25))
    let firstNameField = UITextField(frame: CGRect(x:110, y:60, width:240, height:25))
    
    let lastNameLabel = UILabel(frame: CGRect(x:25, y:90, width:100, height:25))
    let lastNameField = UITextField(frame: CGRect(x:110, y:90, width:240, height:25))
    
    let netIDLabel = UILabel(frame: CGRect(x:25, y:120, width:100, height:25))
    let netIDField = UITextField(frame: CGRect(x:110, y:120, width:240, height:25))
    
    let whereFromLabel = UILabel(frame: CGRect(x:25, y:150, width:100, height:25))
    let whereFromField = UITextField(frame: CGRect(x:110, y:150, width:240, height:25))
    
    let hobbyLabel = UILabel(frame: CGRect(x:25, y:180, width:100, height:25))
    let hobbyField = UITextField(frame: CGRect(x:110, y:180, width:240, height:25))
    
    let degreeLabel = UILabel(frame: CGRect(x:25, y:210, width:100, height:25))
    let degreeField = UITextField(frame: CGRect(x:110, y:210, width:240, height:25))
    
    let languageLabel = UILabel(frame: CGRect(x:25, y:240, width:100, height:25))
    let languageField = UITextField(frame: CGRect(x:110, y:240, width:240, height:25))
    
    let teamLabel = UILabel(frame: CGRect(x:25, y:270, width:100, height:25))
    let teamField = UITextField(frame: CGRect(x:110, y:270, width:240, height:25))
    
    let emailLabel = UILabel(frame: CGRect(x:25, y:300, width:100, height:25))
    let emailField = UITextField(frame: CGRect(x:110, y:300, width:240, height:25))
    
    let genderSegmented = UISegmentedControl(items: ["Male", "Female", "Non-binary"])
    
    let roleSegmented = UISegmentedControl(items: ["Student", "Prof.", "TA"])
    
    @objc let addOrUpdateButton = UIButton(frame:CGRect(x:100, y:400, width:175, height:30))
    
    let flipButton = UIButton(frame:CGRect(x:15, y:400, width:70, height:30))
    
//    let addOrUpdateButton = UIButton(frame:CGRect(x:50, y:400, width:125, height:30))
//
//    let findButton = UIButton(frame:CGRect(x:200, y:400, width:125, height:30))
    
    let backgroundLabel = UILabel(frame: CGRect(x:0, y:435, width:375, height:250))
    
    let outputLabel = UILabel(frame: CGRect(x:100, y:440, width:265, height:180))
    
    let imageButton = UIButton(frame: CGRect(x:10, y:470, width:80, height:80))
        
    // define image picker
    var imagePicker = UIImagePickerController()
    
    @objc func pickAnImage(){
        AudioServicesPlaySystemSound(1105)
        present(imagePicker, animated: true)
    }
    
    // Control selection on album
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("ERROR")
        }
        picker.dismiss(animated: true) { [unowned self] in
            imageButton.setBackgroundImage(selectedImage.copy(newSize: CGSize(width: 144, height: 144)), for: .normal)
        }
    }
    
    // Control cancelation on album
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let view = UIView()
        view.backgroundColor = .white
        
        // Hide keyboard after typing
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
//        label.backgroundColor = UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1)
//        label.text = "ECE 564 Homework 1"
//        label.textColor = .white
//        label.textAlignment = .center
//        label.font = UIFont(name: "Times New Roman", size: 24)
                
        firstNameLabel.text = "First Name:"
        firstNameLabel.font = UIFont(name: "Times New Roman", size: 16)
        firstNameLabel.textColor = .black
        firstNameField.backgroundColor = .white
        firstNameField.borderStyle = .roundedRect
        firstNameField.clearButtonMode = .always
        
        lastNameLabel.text = "Last Name:"
        lastNameLabel.font = UIFont(name: "Times New Roman", size: 16)
        lastNameLabel.textColor = .black
        lastNameField.backgroundColor = .white
        lastNameField.borderStyle = .roundedRect
        lastNameField.clearButtonMode = .always
        
        netIDLabel.text = "NetID:"
        netIDLabel.font = UIFont(name: "Times New Roman", size: 16)
        netIDLabel.textColor = .black
        netIDField.backgroundColor = .white
        netIDField.borderStyle = .roundedRect
        netIDField.clearButtonMode = .always
        
        whereFromLabel.text = "From:"
        whereFromLabel.font = UIFont(name: "Times New Roman", size: 16)
        whereFromLabel.textColor = .black
        whereFromField.backgroundColor = .white
        whereFromField.borderStyle = .roundedRect
        whereFromField.clearButtonMode = .always
        
        hobbyLabel.text = "Hobby:"
        hobbyLabel.font = UIFont(name: "Times New Roman", size: 16)
        hobbyLabel.textColor = .black
        hobbyField.backgroundColor = .white
        hobbyField.placeholder = "e.g., xxx, yyy, zzz"
        hobbyField.borderStyle = .roundedRect
        hobbyField.clearButtonMode = .always
        
        degreeLabel.text = "Degree:"
        degreeLabel.font = UIFont(name: "Times New Roman", size: 16)
        degreeLabel.textColor = .black
        degreeField.backgroundColor = .white
        degreeField.borderStyle = .roundedRect
        degreeField.clearButtonMode = .always
        
        languageLabel.text = "Language:"
        languageLabel.font = UIFont(name: "Times New Roman", size: 16)
        languageLabel.textColor = .black
        languageField.backgroundColor = .white
        languageField.placeholder = "e.g., xxx, yyy, zzz"
        languageField.borderStyle = .roundedRect
        languageField.clearButtonMode = .always
        
        teamLabel.text = "Team:"
        teamLabel.font = UIFont(name: "Times New Roman", size: 16)
        teamLabel.textColor = .black
        teamField.backgroundColor = .white
        teamField.borderStyle = .roundedRect
        teamField.clearButtonMode = .always
        
        emailLabel.text = "Email:"
        emailLabel.font = UIFont(name: "Times New Roman", size: 16)
        emailLabel.textColor = .black
        emailField.backgroundColor = .white
        emailField.placeholder = "If left empty, netid@duke.edu"
        emailField.borderStyle = .roundedRect
        emailField.clearButtonMode = .always
        
        genderSegmented.frame = CGRect(x:50, y:330, width:275, height:30)
        roleSegmented.frame = CGRect(x:50, y:365, width:275, height:30)
        
        addOrUpdateButton.backgroundColor = UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1)
        if fromCell {
            addOrUpdateButton.setTitle("Edit", for: .normal)
            addOrUpdateButton.removeTarget(nil, action: nil, for: .allEvents)
            addOrUpdateButton.addTarget(self, action: #selector(editClicked), for: .touchUpInside)
        } else {
            addOrUpdateButton.setTitle("Save", for: .normal)
            addOrUpdateButton.removeTarget(nil, action: nil, for: .allEvents)
            addOrUpdateButton.addTarget(self, action: #selector(addOrUpdateAction), for: .touchUpInside)
            
        }
        
        addOrUpdateButton.setTitleColor(.white, for: .normal)
        addOrUpdateButton.layer.cornerRadius = 5
        addOrUpdateButton.layer.masksToBounds = true
        
        flipButton.setTitle("Flip", for: .normal)
        flipButton.backgroundColor = UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1)
        flipButton.setTitleColor(.white, for: .normal)
        flipButton.layer.cornerRadius = 5
        flipButton.layer.masksToBounds = true
        flipButton.addTarget(self, action: #selector(flipAction), for: .touchUpInside)
        
//        findButton.backgroundColor = UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1)
//        findButton.addTarget(self, action: #selector(findAction), for: .touchUpInside)
//        findButton.setTitle("Find", for: .normal)
//        findButton.setTitleColor(.white, for: .normal)
//        findButton.layer.cornerRadius = 5
//        findButton.layer.masksToBounds = true
        
        backgroundLabel.backgroundColor = UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1)
        
        outputLabel.backgroundColor = UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1)
        outputLabel.textColor = .white
        outputLabel.textAlignment = .center
        outputLabel.numberOfLines = 0
        
        imageButton.addTarget(self, action: #selector(pickAnImage), for: .touchUpInside)
        // Set image for the button
        
        if !fromCell && !keepImage {
            if let image = UIImage(named: "default") {
                imageButton.setBackgroundImage(image, for: .normal)
            }
        }
        
        // set imagepicker so album can be viewed
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
                
//        view.addSubview(label)
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameField)
        view.addSubview(lastNameLabel)
        view.addSubview(lastNameField)
        view.addSubview(netIDLabel)
        view.addSubview(netIDField)
        view.addSubview(whereFromLabel)
        view.addSubview(whereFromField)
        view.addSubview(hobbyLabel)
        view.addSubview(hobbyField)
        view.addSubview(degreeLabel)
        view.addSubview(degreeField)
        view.addSubview(languageLabel)
        view.addSubview(languageField)
        view.addSubview(teamLabel)
        view.addSubview(teamField)
        view.addSubview(emailLabel)
        view.addSubview(emailField)
//        view.addSubview(findButton)
        view.addSubview(addOrUpdateButton)
        view.addSubview(genderSegmented)
        view.addSubview(roleSegmented)
        view.addSubview(backgroundLabel)
        view.addSubview(outputLabel)
        view.addSubview(imageButton)
        view.addSubview(flipButton)
        
        self.view = view
    }

    // This function is used to get input from textfield or segmenedtcontrol
    func getInput() -> (String, DukePerson) {
        var netID = netIDField.text ?? ""
        netID = netID.lowercased()
        var firstName = firstNameField.text ?? ""
        firstName = firstName.capitalized
        var lastName = lastNameField.text ?? ""
        lastName = lastName.capitalized
        var whereFrom = whereFromField.text ?? ""
        whereFrom = whereFrom.capitalized
        var hobbyString = hobbyField.text ?? ""
        hobbyString = hobbyString.lowercased()
        let hobbyArray = hobbyString.components(separatedBy: ", ")
        let degree = degreeField.text ?? ""
        let languageString = languageField.text ?? ""
        let languageArray = languageString.components(separatedBy: ", ")
        let team = teamField.text ?? ""
        var email = emailField.text ?? ""
        if (email == "") {
            email = netID + "@duke.edu"
        }
        let genderIndex = genderSegmented.selectedSegmentIndex
        // set segment index
        var gender: Gender {
            switch genderIndex {
                case 0: return .Male
                case 1: return .Female
                case 2: return .NonBinary
                default: return .Male
            }
        }
        // set segment index
        let roleIndex = roleSegmented.selectedSegmentIndex
        var role: DukeRole {
            switch roleIndex {
                case 0: return .Student
                case 1: return .Professor
                case 2: return .TA
                default: return .Other
            }
        }
        // return value is a dukePerson object
        let person = DukePerson(firstName: firstName, lastName: lastName, whereFrom: whereFrom, gender: gender, hobbies: hobbyArray, dukeRole: role, NetID: netID, degree: degree, languages: languageArray, team: team, email: email, imageString: "none")
        return (netID, person)
    }
    
    // Do add or update to both the database object and the disk
    @objc func addOrUpdateAction(sender: UIButton) {
        print("Update started.")
        AudioServicesPlaySystemSound(1105)
        let tuple = getInput()
        // Condition: fields empty
        if (tuple.1.firstName == "" || tuple.1.lastName == "" || tuple.1.NetID == "" || tuple.1.hobbies.isEmpty || tuple.1.degree == "" || tuple.1.languages.isEmpty || tuple.1.team == "" || genderSegmented.selectedSegmentIndex == -1 || roleSegmented.selectedSegmentIndex == -1) {
            let message = "Please fill in all the fields except Email."
            outputLabel.text = message
        } else if(tuple.1.firstName.rangeOfCharacter(from: .decimalDigits) != nil || tuple.1.lastName.rangeOfCharacter(from: .decimalDigits) != nil) {
            // Condition: invalid name
            let message = "Please type in a valid name."
            outputLabel.text = message
        } else if (tuple.1.hobbies.count > 3) {
            // Condition: too many hobbies
            let message = "Please enter no more than 3 hobbies."
            outputLabel.text = message
        } else if (tuple.1.languages.count > 3) {
            // Condition: too many languages
            let message = "Please enter no more than 3 languages."
            outputLabel.text = message
        } else {
            // normal case
            tuple.1.imageString = stringFromImage(imageButton.currentBackgroundImage!)
            
            // Change database object and get message
            let message = DataBase.addOrUpdate(netID: tuple.0, dukePerson: tuple.1)
            
            // Load from disk
            var toSave = JSONPerson.loadJSONPersonInfo()!
            toSave[tuple.0] = JSONPerson(dukeperson: tuple.1)
            
            // Save changes to disk
            _ = JSONPerson.saveJSONPersonInfo(toSave)
            
            // After add/update, let all fields be empty.
            outputLabel.text = message
            firstNameField.text = ""
            lastNameField.text = ""
            netIDField.text = ""
            whereFromField.text = ""
            hobbyField.text = ""
            degreeField.text = ""
            languageField.text = ""
            teamField.text = ""
            emailField.text = ""
            genderSegmented.selectedSegmentIndex = -1
            roleSegmented.selectedSegmentIndex = -1
            if let image = UIImage(named: "default") {
                imageButton.setBackgroundImage(image, for: .normal)
            }
            
            if tuple.1.NetID == "cc749" {
                postData()
                
            }
        }
    }
    
    @objc func findAction(sender: UIButton) {
        AudioServicesPlaySystemSound(1105)
        let tuple = getInput()
        if (!DataBase.find(netID: tuple.0)) {
            if let image = UIImage(named: "default") {
                imageButton.setBackgroundImage(image, for: .normal)
            }
            let message = "The person was not found."
            outputLabel.text = message
        } else {
            let message = DataBase.dictionary[tuple.0]?.description
            let person = DataBase.dictionary[tuple.0]
            // If found, let fields and controls also show their corresponding infomation.
            outputLabel.text = message
            firstNameField.text = person?.firstName
            lastNameField.text = person?.lastName
            netIDField.text = person?.NetID
            whereFromField.text = person?.whereFrom
            hobbyField.text = printArray(array: person!.hobbies)
            degreeField.text = person?.degree
            languageField.text = printArray(array: person!.languages)
            teamField.text = person?.team
            emailField.text = person?.email
            genderSegmented.selectedSegmentIndex = showGender(gender: person!.gender)
            roleSegmented.selectedSegmentIndex = showRole(role: person!.dukeRole)
            let image = DataBase.dictionary[tuple.0]!.imageString.toImage()
            imageButton.setBackgroundImage(image, for: .normal)
        }
    }
    
    @objc func editClicked(sender: UIButton) {
        fromCell = false
        keepImage = false
        
        addOrUpdateButton.setTitle("Save", for: .normal)
        
        firstNameField.isUserInteractionEnabled = true
        lastNameField.isUserInteractionEnabled = true
        netIDField.isUserInteractionEnabled = true
        whereFromField.isUserInteractionEnabled = true
        hobbyField.isUserInteractionEnabled = true
        degreeField.isUserInteractionEnabled = true
        languageField.isUserInteractionEnabled = true
        teamField.isUserInteractionEnabled = true
        emailField.isUserInteractionEnabled = true
        genderSegmented.isUserInteractionEnabled = true
        roleSegmented.isUserInteractionEnabled = true
        imageButton.isUserInteractionEnabled = true
        
        addOrUpdateButton.removeTarget(nil, action: nil, for: .allEvents)
        addOrUpdateButton.addTarget(self, action: #selector(addOrUpdateAction), for: .touchUpInside)
    }
    
    @objc func hideKeyboard() {
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        netIDField.resignFirstResponder()
        whereFromField.resignFirstResponder()
        hobbyField.resignFirstResponder()
        degreeField.resignFirstResponder()
        languageField.resignFirstResponder()
    }
    
    @objc func flipAction() {
        if (!(self.netIDField.text == "cc749")) {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let backView = mainStoryBoard.instantiateViewController(withIdentifier: "BackView") as! BackViewController
            backView.modalTransitionStyle = .flipHorizontal
            present(backView, animated: true)
        } else {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let drawingView = mainStoryBoard.instantiateViewController(withIdentifier: "DrawingView") as! DrawingViewController
            drawingView.modalTransitionStyle = .flipHorizontal
            present(drawingView, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
