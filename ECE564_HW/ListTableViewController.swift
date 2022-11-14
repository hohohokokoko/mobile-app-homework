//
//  ListTableViewController.swift
//  ECE564_HW
//
//  Created by 曹畅 on 2021/10/2.
//  Copyright © 2021 ECE564. All rights reserved.
//

import Foundation
import UIKit

class ListTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
//    var dukePersons = [DukePerson]()
    // This is used to store complete role: [DukePerson] relationships.
    var sectionDic = [String: [DukePerson]]()
    // This is used to store filtered role: [DukePerson] relationships.
    var filteredSections = [String: [DukePerson]]()
    
    var infomationVC = InformationViewController()
    
    // After initial loading, downloading (replacing/updating), editing, or returning from other views,
    // dictionary will be updated.
    func updateSectionDic() {
        sectionDic = [String: [DukePerson]]()
        for key in DataBase.dictionary.keys {
            let person = DataBase.dictionary[key]!
            if person.dukeRole.rawValue == "Professor" {
                if sectionDic["Professor"] != nil {
                    sectionDic["Professor"]!.append(person)
                } else {
                    sectionDic["Professor"] = [DukePerson]()
                    sectionDic["Professor"]!.append(person)
                }
            } else if person.dukeRole.rawValue == "Teaching Assistant" {
                if sectionDic["Teaching Assistant"] != nil {
                    sectionDic["Teaching Assistant"]!.append(person)
                } else {
                    sectionDic["Teaching Assistant"] = [DukePerson]()
                    sectionDic["Teaching Assistant"]!.append(person)
                }
            } else {
                let team = person.team
                if team == "" || team == "None" || team == "none" || team == "N/A" {
                    if sectionDic["Student"] != nil {
                        sectionDic["Student"]!.append(person)
                    } else {
                        sectionDic["Student"] = [DukePerson]()
                        sectionDic["Student"]!.append(person)
                    }
                } else {
                    if sectionDic[team] != nil {
                        sectionDic[team]!.append(person)
                    } else {
                        sectionDic[team] = [DukePerson]()
                        sectionDic[team]!.append(person)
                    }
                }
            }
        }
        filteredSections = sectionDic
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        loadInitialData()
        updateSectionDic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        infomationVC.fromCell = false
        infomationVC.keepImage = false
        
        self.updateSectionDic()

        self.tableView.reloadData()
    }
    
    // Alert need to be in viewDidAppear()
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // This is an alert asking you whether to sync from server.
        let alert = UIAlertController(title: "Do you want to sync your data from the server?", message: "You can replace or update your data on the disk from the server.", preferredStyle: .alert)

        // three actions related to the alert
        alert.addAction(UIAlertAction(title: "Yes, replace", style: .default, handler: {
            action in replaceDownloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {

//                self.dukePersons = [DukePerson]()
//                let dukePersonValues = Array(DataBase.dictionary.values)
//                for dukePerson in dukePersonValues {
//                    self.dukePersons.append(dukePerson)
//                }
                
                self.updateSectionDic()
                
                self.tableView.reloadData()
                        })
        }))
        alert.addAction(UIAlertAction(title: "Yes, update", style: .default, handler: {
            action in updateDownloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {

//                self.dukePersons = [DukePerson]()
//                let dukePersonValues = Array(DataBase.dictionary.values)
//                for dukePerson in dukePersonValues {
//                    self.dukePersons.append(dukePerson)
//                }
                
                self.updateSectionDic()
                
                self.tableView.reloadData()
                        })
        }))
        alert.addAction(UIAlertAction(title: "No, thanks", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
    
    func loadInitialData() {
        if let jsonPersons = JSONPerson.loadJSONPersonInfo() {
            // Condition: Disk is not empty
            var dukePersons = [String: DukePerson]()
            for key in jsonPersons.keys {
                dukePersons[key] = jsonPersons[key]?.getDukePerson()
            }
            DataBase.dictionary = dukePersons
            
//            let dukePersonValues = Array(DataBase.dictionary.values)
//            for dukePerson in dukePersonValues {
//                self.dukePersons.append(dukePerson)
//            }
            
        } else {
            // Condition: Disk is empty
            var toSave = [String: JSONPerson]()
            
            // When saving to disk, transfer DukePerson to JsonPerson
            let rt113 = DukePerson(firstName: "Richard", lastName: "Telford", whereFrom: "Chatham County, NC", gender: .Male, hobbies: ["swimming", "biking", "reading"], dukeRole: .Professor, NetID: "rt113", degree: "PhD", languages: ["Swift", "C", "C++"], team: "none", email: "rt113@duke.edu", imageString: stringFromImage(imageFromName("rt113").copy(newSize: CGSize(width: 144, height: 144))!))
            toSave["rt113"] = JSONPerson(dukeperson: rt113)
            _ = DataBase.addOrUpdate(netID: "rt113", dukePerson: rt113)
            
            let as866 = DukePerson(firstName: "Abhijay", lastName: "Suhag", whereFrom: "Augusta, Georgia", gender: .Male, hobbies: ["hiking", "gaming", "playing tennis"], dukeRole: .TA, NetID: "as866", degree: "Bachelor of Science", languages: ["Typescript", "Swift", "Java"], team: "none", email: "as866@duke.edu", imageString: stringFromImage(imageFromName("as866").copy(newSize: CGSize(width: 144, height: 144))!))
            toSave["as866"] = JSONPerson(dukeperson: as866)
            _ = DataBase.addOrUpdate(netID: "as866", dukePerson: as866)
            
            let ak513 = DukePerson(firstName: "Andrew", lastName: "Krier", whereFrom: "Saint Paul, Minnesota", gender: .Male, hobbies: ["basketball", "frisbee"], dukeRole: .TA, NetID: "ak513", degree: "Undergrad", languages: ["Swift", "Java", "Python"], team: "none", email: "ak513@duke.edu", imageString: stringFromImage(imageFromName("ak513").copy(newSize: CGSize(width: 144, height: 144))!))
            toSave["ak513"] = JSONPerson(dukeperson: ak513)
            _ = DataBase.addOrUpdate(netID: "ak513", dukePerson: ak513)
            
            let cc749 = DukePerson(firstName: "Chang", lastName: "Cao", whereFrom: "Ningbo, China", gender: .Male, hobbies: ["hiking", "watching movies"], dukeRole: .Student, NetID: "cc749", degree: "Bachelor of Engineering", languages: ["Java", "Python", "Swift"], team: "ApneaApp", email: "cc749@duke.edu", imageString: stringFromImage(imageFromName("cc749").copy(newSize: CGSize(width: 144, height: 144))!))
            toSave["cc749"] = JSONPerson(dukeperson: cc749)
            _ = DataBase.addOrUpdate(netID: "cc749", dukePerson: cc749)
            
            let zy108 = DukePerson(firstName: "Zilin", lastName: "Yin", whereFrom: "Shenzhen, China", gender: .Male, hobbies: ["eating food"], dukeRole: .Student, NetID: "zy108", degree: "Master of Science", languages: ["Java", "Swift", "Python", "C", "C++"], team: "ApneaApp", email: "zy108@duke.edu", imageString: stringFromImage(imageFromName("zy108").copy(newSize: CGSize(width: 144, height: 144))!))
            toSave["zy108"] = JSONPerson(dukeperson: zy108)
            _ = DataBase.addOrUpdate(netID: "zy108", dukePerson: zy108)
            
            let yz566 = DukePerson(firstName: "Yutong", lastName: "Zhang", whereFrom: "Hebei, China", gender: .Female, hobbies: ["Kongfu"], dukeRole: .Student, NetID: "yz566", degree: "Master of Science", languages: ["Java", "Matlab"], team: "ApneaApp", email: "yz566@duke.edu", imageString: stringFromImage(imageFromName("yz566").copy(newSize: CGSize(width: 144, height: 144))!))
            toSave["yz566"] = JSONPerson(dukeperson: yz566)
            _ = DataBase.addOrUpdate(netID: "yz566", dukePerson: yz566)
            
            // save to disk
            let _ = JSONPerson.saveJSONPersonInfo(toSave)
            
//            let dukePersonValues = Array(DataBase.dictionary.values)
//            for dukePerson in dukePersonValues {
//                self.dukePersons.append(dukePerson)
//            }
        }
    }
    
    // define number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.filteredSections.count
    }
    
    // define height of row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165
    }

    // define number of rows in a section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var keyArray = [String]()
        for key in Array(self.filteredSections.keys) {
            keyArray.append(String(key))
        }
        keyArray.sort(by: <)
        return filteredSections[keyArray[section]]!.count
    }
    
    // define section header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var keyArray = [String]()
        for key in Array(self.filteredSections.keys) {
            keyArray.append(String(key))
        }
        keyArray.sort(by: <)
        return keyArray[section]
    }
    
    // define contents of a cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "dukePersonsProtoCell")
        
        var keyArray = [String]()
        for key in Array(self.filteredSections.keys) {
            keyArray.append(String(key))
        }
        keyArray.sort(by: <)
        
        let persons: [DukePerson] = self.filteredSections[keyArray[indexPath.section]]!
        let person = persons[indexPath.row]
        var image = person.imageString.toImage()
        image = image ?? UIImage(named: "default")
        image = image!.copy(newSize: CGSize(width: 100, height: 100))
        cell.imageView?.image = image
        cell.textLabel?.text = person.firstName + " " + person.lastName + " (" + person.NetID + ")"
        cell.detailTextLabel?.text = person.description
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "dukePersonsProtoCell", for: indexPath)
//        let dukePerson: DukePerson = self.dukePersons[indexPath.row]
//        cell.textLabel?.text = dukePerson.NetID
        
        return cell
    }
    
    // filter dictionary for searching text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredSections = sectionDic
        } else {
            let lowSearchText = searchText.lowercased()
            var tempDic = [String: [DukePerson]]()
            for role in sectionDic.keys {
                for person in sectionDic[role]! {
                    if person.NetID.contains(lowSearchText) {
                        if tempDic[role] == nil {
                            tempDic[role] = [DukePerson]()
                            tempDic[role]?.append(person)
                        } else {
                            tempDic[role]?.append(person)
                        }
                    }
                }
                
            }
            filteredSections = tempDic
        }

        tableView.reloadData()
    }
    
    // select to jump to imformation view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var keyArray = [String]()
        for key in Array(self.filteredSections.keys) {
            keyArray.append(String(key))
        }
        keyArray.sort(by: <)
        
        let persons: [DukePerson] = self.filteredSections[keyArray[indexPath.section]]!
        let person = persons[indexPath.row]
        
        infomationVC.outputLabel.text = person.description
        infomationVC.firstNameField.text = person.firstName
        infomationVC.firstNameField.isUserInteractionEnabled = false
        infomationVC.lastNameField.text = person.lastName
        infomationVC.lastNameField.isUserInteractionEnabled = false
        infomationVC.netIDField.text = person.NetID
        infomationVC.netIDField.isUserInteractionEnabled = false
        infomationVC.whereFromField.text = person.whereFrom
        infomationVC.whereFromField.isUserInteractionEnabled = false
        infomationVC.hobbyField.text = printArray(array: person.hobbies)
        infomationVC.hobbyField.isUserInteractionEnabled = false
        infomationVC.degreeField.text = person.degree
        infomationVC.degreeField.isUserInteractionEnabled = false
        infomationVC.languageField.text = printArray(array: person.languages)
        infomationVC.languageField.isUserInteractionEnabled = false
        infomationVC.teamField.text = person.team
        infomationVC.teamField.isUserInteractionEnabled = false
        infomationVC.emailField.text = person.email
        infomationVC.emailField.isUserInteractionEnabled = false
        infomationVC.genderSegmented.selectedSegmentIndex = showGender(gender: person.gender)
        infomationVC.genderSegmented.isUserInteractionEnabled = false
        infomationVC.roleSegmented.selectedSegmentIndex = showRole(role: person.dukeRole)
        infomationVC.roleSegmented.isUserInteractionEnabled = false
        let image = person.imageString.toImage()
        infomationVC.imageButton.setBackgroundImage(image, for: .normal)
        infomationVC.imageButton.isUserInteractionEnabled = false
        
        infomationVC.fromCell = true
        infomationVC.keepImage = true
        
        infomationVC.addOrUpdateButton.setTitle("Edit", for: .normal)
        infomationVC.addOrUpdateButton
            .removeTarget(nil, action: nil, for: .allEvents)
        infomationVC.addOrUpdateButton.addTarget(infomationVC, action: #selector(infomationVC.editClicked), for: .touchUpInside)
        
        self.show(infomationVC, sender: self)
    }
    
    // swipe to delete and edit
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            var keyArray = [String]()
            for key in Array(self.filteredSections.keys) {
            keyArray.append(String(key))
                }
            keyArray.sort(by: <)
            
            let persons: [DukePerson] = self.filteredSections[keyArray[indexPath.section]]!
            let person = persons[indexPath.row]
            
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                DataBase.delete(netID: person.NetID)
                
                // Load from disk
                var toSave = JSONPerson.loadJSONPersonInfo()!
                toSave.removeValue(forKey: person.NetID)
                
                // Save changes to disk
                _ = JSONPerson.saveJSONPersonInfo(toSave)
            
                self.updateSectionDic()
                self.tableView.reloadData()
                completionHandler(true)
            }
            let editAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                self.infomationVC.outputLabel.text = person.description
                self.infomationVC.firstNameField.text = person.firstName
                self.infomationVC.lastNameField.text = person.lastName
                self.infomationVC.netIDField.text = person.NetID
                self.infomationVC.whereFromField.text = person.whereFrom
                self.infomationVC.hobbyField.text = printArray(array: person.hobbies)
                self.infomationVC.degreeField.text = person.degree
                self.infomationVC.languageField.text = printArray(array: person.languages)
                self.infomationVC.teamField.text = person.team
                self.infomationVC.emailField.text = person.email
                self.infomationVC.genderSegmented.selectedSegmentIndex = showGender(gender: person.gender)
                self.infomationVC.roleSegmented.selectedSegmentIndex = showRole(role: person.dukeRole)
                let image = person.imageString.toImage()
                self.infomationVC.imageButton.setBackgroundImage(image, for: .normal)
                self.show(self.infomationVC, sender: self)
                
                self.infomationVC.fromCell = false
                self.infomationVC.keepImage = true
                
                self.infomationVC.addOrUpdateButton.setTitle("Save", for: .normal)
                self.infomationVC.addOrUpdateButton
                    .removeTarget(nil, action: nil, for: .allEvents)
                self.infomationVC.addOrUpdateButton.addTarget(self.infomationVC, action: #selector(self.infomationVC.editClicked), for: .touchUpInside)
                completionHandler(true)
            }
        
            deleteAction.image = UIImage(systemName: "trash")
            deleteAction.backgroundColor = .systemRed
            editAction.image = UIImage(systemName: "pencil")
            editAction.backgroundColor = .systemGray
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
            return configuration
    }
    
    @IBAction func returnFromNewDukePerson(segue: UIStoryboardSegue) {
//        self.dukePersons = [DukePerson]()
//        let dukePersonValues = Array(DataBase.dictionary.values)
//        for dukePerson in dukePersonValues {
//            self.dukePersons.append(dukePerson)
//        }
                
        infomationVC.fromCell = false
        infomationVC.keepImage = false
        
        self.updateSectionDic()

        self.tableView.reloadData()
    }
}
