//
//  DataModel.swift
//  ECE564_HW
//
//  Created by 曹畅 on 2021/9/8.
//  Copyright © 2021 ECE564. All rights reserved.
//

import Foundation

// Unknown is for bad data from server
enum Gender : String, Codable {
    case Male = "Male"
    case Female = "Female"
    case NonBinary = "Non-binary"
    case Unknown = "Unknown"
}

// Unknown is for bad data from server
enum DukeRole : String, Codable {
    case Student = "Student"
    case Professor = "Professor"
    case TA = "Teaching Assistant"
    case Other = "Other"
    case Unknown = "Unknown"
}

protocol ECE564 {
    var degree : String { get }
    var languages: [String] { get }
    var team : String { get }
}

class Person {
    var firstName = "First"
    var lastName = "Last"
    var whereFrom = "Anywhere"  // this is just a free String - can be city, state, both, etc.
    var gender : Gender = .Male
    var hobbies = ["none"]
    
//    override init() {
//        super.init()
//    }
    
    init(firstName: String, lastName: String, whereFrom: String, gender: Gender, hobbies: [String]) {
        self.firstName = firstName
        self.lastName = lastName
        self.whereFrom = whereFrom
        self.gender = gender
        self.hobbies = hobbies
        
//        super.init()
    }
}

// DukePerson is for storage in DataBase object
class DukePerson : Person, ECE564, CustomStringConvertible {
    var dukeRole: DukeRole
    var NetID: String = "netid"
    var degree: String = "degree"
    var languages: [String] = ["none"]
    var team: String = "none"
    var email : String = "none"
    var imageString: String = "none"
    var department: String = "none"
    var id: String = "none"
    
    init(firstName: String, lastName: String, whereFrom: String, gender: Gender, hobbies: [String], dukeRole: DukeRole, NetID: String, degree: String, languages: [String], team: String, email: String, imageString: String) {
        self.dukeRole = dukeRole
        self.NetID = NetID
        self.degree = degree
        self.languages = languages
        self.team = team
        self.email = email
        self.imageString = imageString
        
        super.init(firstName: firstName, lastName: lastName, whereFrom: whereFrom, gender: gender, hobbies: hobbies)
    }
    
    var description: String {
        var pronoun = ""
        switch gender {
        case .Male:
            pronoun = "He"
        case .Female:
            pronoun = "She"
        case .NonBinary:
            pronoun = "He/She"
        case .Unknown:
            pronoun = "It"
        }
        var possessivePronoun = ""
        switch gender {
        case .Male:
            possessivePronoun = "His"
        case .Female:
            possessivePronoun = "Her"
        case .NonBinary:
            possessivePronoun = "His/Her"
        case .Unknown:
            possessivePronoun = "Its"
        }

        
        var hobbiesString = ""
        for item in hobbies {
            hobbiesString = hobbiesString + ", " + item
        }
        hobbiesString.remove(at: hobbiesString.startIndex)
        
        var languagesString = ""
        for item in languages {
            languagesString = languagesString + ", " + item
        }
        languagesString.remove(at: languagesString.startIndex)
        
        return firstName + " " + lastName + " (" + NetID + ") is from " + whereFrom + ". " + pronoun + " likes" + hobbiesString + ". " + pronoun + " is a " + degree + ". " + pronoun + " knows" + languagesString + ". " + pronoun + " is a " + gender.rawValue + ". " + pronoun + " is a " + dukeRole.rawValue + " at ECE564. " + possessivePronoun + " team is " + team + ". " + possessivePronoun + " email is " + email + "."
    }
}

// JSONPerson is for storage in disk
class JSONPerson: NSObject, Codable {
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("DukePersonJSONFile")
    
    var firstname: String
    var lastname: String
    var wherefrom: String
    var gender: String
    var hobbies: [String]
    var role: String
    var degree: String
    var languages: [String]
    var picture: String
    var team: String
    var netid: String
    var email: String
    var department: String
    var id: String
    
    init(dukeperson: DukePerson) {
        self.firstname = dukeperson.firstName
        self.lastname = dukeperson.lastName
        self.wherefrom = dukeperson.whereFrom
        self.gender = dukeperson.gender.rawValue
        self.hobbies = dukeperson.hobbies
        self.role = dukeperson.dukeRole.rawValue
        self.degree = dukeperson.degree
        self.languages = dukeperson.languages
        self.picture = dukeperson.imageString
        self.team = dukeperson.team
        self.netid = dukeperson.NetID
        self.email = dukeperson.email
        self.department = dukeperson.department
        self.id = dukeperson.id
        super.init()
    }
    
    // change from jsonperson to dukeperson
    func getDukePerson() -> DukePerson {
        // handle bad enum value
        var safeGender = self.gender
        if safeGender != "Male" && safeGender != "Female" && safeGender != "Non-binary" {
            safeGender = "Unknown"
        }
        // handle bad enum value
        var safeRole = self.role
        if safeRole != "Student" && safeRole != "Professor" && safeRole != "Teaching Assistant" && safeRole != "TA" && safeRole != "Other" {
            safeRole = "Unknown"
        }
        if safeRole == "TA" {
            safeRole = "Teaching Assistant"
        }
        let dukePerson = DukePerson(firstName: self.firstname, lastName: self.lastname, whereFrom: self.wherefrom, gender: Gender(rawValue: safeGender) ?? .Male, hobbies: self.hobbies, dukeRole: DukeRole(rawValue: safeRole) ?? .Other, NetID: self.netid, degree: self.degree, languages: self.languages, team: self.team, email: self.email, imageString: self.picture)
        return dukePerson
    }
    
    // encode and write JSONPerson to disk
    static func saveJSONPersonInfo(_ JSONPersonDict: [String: JSONPerson]) -> Bool {
        var outputData = Data()
        let encoder = JSONEncoder()
        // do encode
        if let encoded = try? encoder.encode(JSONPersonDict) {
            if let json = String(data: encoded, encoding: .utf8) {
//                print(json)
                outputData = encoded
            }
            else { return false }
            
            do {
                try outputData.write(to: ArchiveURL)
            } catch let error as NSError {
                print (error)
                return false
            }
            return true
        }
        else { return false }
    }
    
    // load JSONPerson from disk
    static func loadJSONPersonInfo() -> [String: JSONPerson]? {
        let decoder = JSONDecoder()
        var dukePersonItems = [String: JSONPerson]()
        let tempData: Data
        
        do {
            tempData = try Data(contentsOf: ArchiveURL)
        } catch let error as NSError {
            print(error)
            return nil
        }
        // do decode
        if let decoded = try? decoder.decode([String: JSONPerson].self, from: tempData) {
            dukePersonItems = decoded
        }
/*
 NOTE:  "xxx.self" evaluates to the value of the type. Use this form to access a type as a value. For example, because SomeClass.self evaluates to the SomeClass type itself, you can pass it to a function or method that accepts a type-level argument.  (From Swift Language Guide)
 */
        return dukePersonItems
    }
}

class DataBase {    
    static var dictionary: [String: DukePerson] = [:]
    
    // util find
    static func find(netID: String) -> Bool {
        return DataBase.dictionary.keys.contains(netID)
    }
    
    // util add or update
    static func addOrUpdate(netID: String, dukePerson: DukePerson) -> String {
        if find(netID: netID) {
            DataBase.dictionary[netID] = dukePerson
            print("update========")
            return "The person has been updated."
        } else {
            DataBase.dictionary[netID] = dukePerson
            return "The person has been added."
        }
    }
    
    // util replace
    static func replace(dict: [String: DukePerson]) -> String {
        DataBase.dictionary = dict
        return "Local data has been replaced."
    }
    
    // util delete
    static func delete(netID: String) {
        DataBase.dictionary.removeValue(forKey: netID)
    }
}
