//: This is the playground file to use for submitting HW1.  You will add your code where noted below.  Make sure you only put the code required at load time in the ``loadView()`` method.  Other code should be set up as additional methods (such as the code called when a button is pressed).
  
import UIKit
import PlaygroundSupport

enum Gender : String {
    case Male = "Male"
    case Female = "Female"
    case NonBinary = "Non-binary"
}

class Person {
    var firstName = "First"
    var lastName = "Last"
    var whereFrom = "Anywhere"  // this is just a free String - can be city, state, both, etc.
    var gender : Gender = .Male
    var hobbies = ["none"]
    init(firstName: String, lastName: String, whereFrom: String, gender: Gender, hobbies: [String]) {
        self.firstName = firstName
        self.lastName = lastName
        self.whereFrom = whereFrom
        self.gender = gender
        self.hobbies = hobbies
    }
}

enum DukeRole : String {
    case Student = "Student"
    case Professor = "Professor"
    case TA = "Teaching Assistant"
    case Other = "Other"
}

protocol ECE564 {
    var degree : String { get }
    var languages: [String] { get }
    var team : String { get }
}

// You can add code here
class DukePerson : Person, ECE564, CustomStringConvertible {
    var dukeRole: DukeRole
    var NetID: String = "netid"
    var degree: String = "degree"
    var languages: [String] = ["none"]
    var team: String = "team"
    
    init(firstName: String, lastName: String, whereFrom: String, gender: Gender, hobbies: [String], dukeRole: DukeRole, NetID: String, degree: String, languages: [String]) {
        self.dukeRole = dukeRole
        self.NetID = NetID
        self.degree = degree
        self.languages = languages
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
        
        return firstName + " " + lastName + " (" + NetID + ") is from " + whereFrom + ". " + pronoun + " likes" + hobbiesString + ". " + pronoun + " is a " + degree + ". " + pronoun + " knows" + languagesString + ". " + pronoun + " is a " + gender.rawValue + ". " + pronoun + " is a " + dukeRole.rawValue + " at ECE564."
    }
}

class DataBase {
    var dictionary: [String: DukePerson] = [:]
    
    func find(netID: String) -> Bool {
        return dictionary.keys.contains(netID)
    }
    
    func addOrUpdate(netID: String, dukePerson: DukePerson) -> String {
        if find(netID: netID) {
            dictionary[netID] = dukePerson
            return "The person has been updated."
        } else {
            dictionary[netID] = dukePerson
            return "The person has been added."
        }
    }
}

class HW1ViewController : UIViewController {
    let database = DataBase()
    
    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 375, height: 50))
    
    let firstNameLabel = UILabel(frame: CGRect(x:25, y:75, width:100, height:25))
    let firstNameField = UITextField(frame: CGRect(x:125, y:75, width:225, height:25))
    
    let lastNameLabel = UILabel(frame: CGRect(x:25, y:110, width:100, height:25))
    let lastNameField = UITextField(frame: CGRect(x:125, y:110, width:225, height:25))
    
    let netIDLabel = UILabel(frame: CGRect(x:25, y:145, width:100, height:25))
    let netIDField = UITextField(frame: CGRect(x:125, y:145, width:225, height:25))
    
    let whereFromLabel = UILabel(frame: CGRect(x:25, y:180, width:100, height:25))
    let whereFromField = UITextField(frame: CGRect(x:125, y:180, width:225, height:25))
    
    let hobbyLabel = UILabel(frame: CGRect(x:25, y:215, width:100, height:25))
    let hobbyField = UITextField(frame: CGRect(x:125, y:215, width:225, height:25))
    
    let degreeLabel = UILabel(frame: CGRect(x:25, y:250, width:100, height:25))
    let degreeField = UITextField(frame: CGRect(x:125, y:250, width:225, height:25))
    
    let languageLabel = UILabel(frame: CGRect(x:25, y:285, width:100, height:25))
    let languageField = UITextField(frame: CGRect(x:125, y:285, width:225, height:25))
    
    let genderSegmented = UISegmentedControl(items: ["Male", "Female", "Non-binary"])
    
    let roleSegmented = UISegmentedControl(items: ["Student", "Prof.", "TA"])
    
    let addOrUpdateButton = UIButton(frame:CGRect(x:50, y:430, width:125, height:40))
    
    let findButton = UIButton(frame:CGRect(x:200, y:430, width:125, height:40))
    
    let outputLabel = UILabel(frame: CGRect(x:0, y:480, width:375, height:188))
    
    override func loadView() {
        // You can change color scheme if you wish
        let view = UIView()
        view.backgroundColor = .white
        
        database.dictionary["rt113"] = DukePerson(firstName: "Richard", lastName: "Telford", whereFrom: "Chatham County, NC", gender: .Male, hobbies: ["swimming", "biking", "reading"], dukeRole: .Professor, NetID: "rt113", degree: "PhD", languages: ["Swift", "C", "C++"])
        database.dictionary["as866"] = DukePerson(firstName: "Abhijay", lastName: "Suhag", whereFrom: "Augusta, Georgia", gender: .Male, hobbies: ["hiking", "gaming", "playing tennis"], dukeRole: .TA, NetID: "as866", degree: "Bachelor of Science", languages: ["Typescript", "Swift", "Java"])
        database.dictionary["ak513"] = DukePerson(firstName: "Andrew", lastName: "Krier", whereFrom: "Saint Paul, Minnesota", gender: .Male, hobbies: ["basketball", "frisbee"], dukeRole: .TA, NetID: "ak513", degree: "Undergrad", languages: ["Swift", "Java", "Python"])
        database.dictionary["cc749"] = DukePerson(firstName: "Chang", lastName: "Cao", whereFrom: "Ningbo, China", gender: .Male, hobbies: ["hiking", "watching movies"], dukeRole: .Student, NetID: "cc749", degree: "Bachelor of Engineering", languages: ["Java", "Python", "Swift"])
        database.dictionary["zy108"] = DukePerson(firstName: "Zilin", lastName: "Yin", whereFrom: "Shenzhen, China", gender: .Male, hobbies: ["eating food"], dukeRole: .Student, NetID: "zy108", degree: "Master of Science", languages: ["Java", "Swift", "Python", "C", "C++"])
        database.dictionary["yz566"] = DukePerson(firstName: "Yutong", lastName: "Zhang", whereFrom: "Hebei, China", gender: .Female, hobbies: ["Kongfu"], dukeRole: .Student, NetID: "yz566", degree: "Master of Science", languages: ["Java", "Matlab"])
        
        label.backgroundColor = UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1)
        label.text = "ECE 564 Homework 1"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Times New Roman", size: 24)
                
        firstNameLabel.text = "First Name:"
        firstNameLabel.font = UIFont(name: "Times New Roman", size: 18)
        firstNameLabel.textColor = .black
        firstNameField.backgroundColor = .white
        firstNameField.borderStyle = .roundedRect
        firstNameField.clearButtonMode = .always
        
        lastNameLabel.text = "Last Name:"
        lastNameLabel.font = UIFont(name: "Times New Roman", size: 18)
        lastNameLabel.textColor = .black
        lastNameField.backgroundColor = .white
        lastNameField.borderStyle = .roundedRect
        lastNameField.clearButtonMode = .always
        
        netIDLabel.text = "NetID:"
        netIDLabel.font = UIFont(name: "Times New Roman", size: 18)
        netIDLabel.textColor = .black
        netIDField.backgroundColor = .white
        netIDField.borderStyle = .roundedRect
        netIDField.clearButtonMode = .always
        
        whereFromLabel.text = "From:"
        whereFromLabel.font = UIFont(name: "Times New Roman", size: 18)
        whereFromLabel.textColor = .black
        whereFromField.backgroundColor = .white
        whereFromField.borderStyle = .roundedRect
        whereFromField.clearButtonMode = .always
        
        hobbyLabel.text = "Hobby:"
        hobbyLabel.font = UIFont(name: "Times New Roman", size: 18)
        hobbyLabel.textColor = .black
        hobbyField.backgroundColor = .white
        hobbyField.placeholder = "e.g., xxx, yyy, zzz"
        hobbyField.borderStyle = .roundedRect
        hobbyField.clearButtonMode = .always
        
        degreeLabel.text = "Degree:"
        degreeLabel.font = UIFont(name: "Times New Roman", size: 18)
        degreeLabel.textColor = .black
        degreeField.backgroundColor = .white
        degreeField.borderStyle = .roundedRect
        degreeField.clearButtonMode = .always
        
        languageLabel.text = "Language:"
        languageLabel.font = UIFont(name: "Times New Roman", size: 18)
        languageLabel.textColor = .black
        languageField.backgroundColor = .white
        languageField.placeholder = "e.g., xxx, yyy, zzz"
        languageField.borderStyle = .roundedRect
        languageField.clearButtonMode = .always
        
        genderSegmented.frame = CGRect(x:50, y:330, width:275, height:35)
        roleSegmented.frame = CGRect(x:50, y:375, width:275, height:35)
        
        addOrUpdateButton.backgroundColor = UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1)
        addOrUpdateButton.addTarget(self, action: #selector(addOrUpdateAction), for: .touchUpInside)
        addOrUpdateButton.setTitle("Add/Update", for: .normal)
        addOrUpdateButton.setTitleColor(.white, for: .normal)
        addOrUpdateButton.layer.cornerRadius = 5
        addOrUpdateButton.layer.masksToBounds = true
        
        findButton.backgroundColor = UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1)
        findButton.addTarget(self, action: #selector(findAction), for: .touchUpInside)
        findButton.setTitle("Find", for: .normal)
        findButton.setTitleColor(.white, for: .normal)
        findButton.layer.cornerRadius = 5
        findButton.layer.masksToBounds = true
        
        outputLabel.backgroundColor = UIColor(red: 1/255, green: 33/255, blue: 105/255, alpha: 1)
        outputLabel.textColor = .white
        outputLabel.textAlignment = .center
        outputLabel.numberOfLines = 0
        
        view.addSubview(label)
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
        view.addSubview(findButton)
        view.addSubview(addOrUpdateButton)
        view.addSubview(genderSegmented)
        view.addSubview(roleSegmented)
        view.addSubview(outputLabel)
        
        self.view = view
        
        // You can add code here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
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
        let genderIndex = genderSegmented.selectedSegmentIndex
        var gender: Gender {
            switch genderIndex {
                case 0: return .Male
                case 1: return .Female
                case 2: return .NonBinary
                default: return .Male
            }
        }
        let roleIndex = roleSegmented.selectedSegmentIndex
        var role: DukeRole {
            switch roleIndex {
                case 0: return .Student
                case 1: return .Professor
                case 2: return .TA
                default: return .Other
            }
        }
        let person = DukePerson(firstName: firstName, lastName: lastName, whereFrom: whereFrom, gender: gender, hobbies: hobbyArray, dukeRole: role, NetID: netID, degree: degree, languages: languageArray)
        return (netID, person)
    }
    
    func showGender(gender: Gender) -> Int {
        var index: Int {
            switch gender {
                case .Male: return 0
                case .Female: return 1
                case .NonBinary: return 2
            }
        }
        return index
    }
    
    func showRole(role: DukeRole) -> Int {
        var index: Int {
            switch role {
                case .Student: return 0
                case .Professor: return 1
                case .TA: return 2
                case .Other: return -1
            }
        }
        return index
    }
    
    func printArray(array: [String]) -> String {
        var str = ""
        for item in array {
            str = str + ", " + item
        }
        str.remove(at: str.startIndex)
        str.remove(at: str.startIndex)
        return str
    }
    
    // You can add code here
    @objc func addOrUpdateAction(sender: UIButton) {
        let tuple = getInput()
        let message = database.addOrUpdate(netID: tuple.0, dukePerson: tuple.1)
        outputLabel.text = message
        firstNameField.text = ""
        lastNameField.text = ""
        netIDField.text = ""
        whereFromField.text = ""
        hobbyField.text = ""
        degreeField.text = ""
        languageField.text = ""
        genderSegmented.selectedSegmentIndex = -1
        roleSegmented.selectedSegmentIndex = -1
    }
    
    @objc func findAction(sender: UIButton) {
        let tuple = getInput()
        if (!database.find(netID: tuple.0)) {
            let message = "The person was not found."
            outputLabel.text = message
        } else {
            let message = database.dictionary[tuple.0]?.description
            let person = database.dictionary[tuple.0]
            outputLabel.text = message
            firstNameField.text = person?.firstName
            lastNameField.text = person?.lastName
            netIDField.text = person?.NetID
            whereFromField.text = person?.whereFrom
            hobbyField.text = printArray(array: person!.hobbies)
            degreeField.text = person?.degree
            languageField.text = printArray(array: person!.languages)
            genderSegmented.selectedSegmentIndex = showGender(gender: person!.gender)
            roleSegmented.selectedSegmentIndex = showRole(role: person!.dukeRole)
        }
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
}

// Don't change the following line - it is what allows the view controller to show in the Live View window
PlaygroundPage.current.liveView = HW1ViewController()
