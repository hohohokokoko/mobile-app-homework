//
//  Communications.swift
//  ECE564_HW
//
//  Created by 曹畅 on 2021/9/22.
//  Copyright © 2021 ECE564. All rights reserved.
//

import Foundation

// authenticaiton info
let username = "cc749"
let password = "9BB7A6F4C516DF94C0F2B6686FF6721A"
let loginString = username + ":" + password
let loginBase64 = loginString.data(using: String.Encoding.utf8)!.base64EncodedString()

// When syncing, replace local data
func replaceDownloadData() {
    let url = URL(string: "http://kitura-fall-2021.vm.duke.edu:5640/b64entries")
    guard let requestUrl = url else {
        fatalError()
    }

    var request = URLRequest(url: requestUrl)
    // set header
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Basic \(loginBase64)", forHTTPHeaderField: "Authorization")

    var jsonPersonList = [JSONPerson]()

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
            return
        }

        // status code
        if let response = response as? HTTPURLResponse {
            print("Status code: \(response.statusCode)")
        }

        // response body
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
//            print("Data string:\n\(dataString)")
            jsonPersonList = parseJSONPerson(data: data)!
        }

        // replace database and disk
        var toSaveJSONPerson = [String: JSONPerson]()
        var toSaveDukePerson = [String: DukePerson]()
        for jsonPerson in jsonPersonList {
            toSaveJSONPerson[jsonPerson.netid] = jsonPerson
            let dukePerson = jsonPerson.getDukePerson()
            toSaveDukePerson[dukePerson.NetID] = dukePerson
        }
        let message = DataBase.replace(dict: toSaveDukePerson)

        // save to disk
        let _ = JSONPerson.saveJSONPersonInfo(toSaveJSONPerson)

        print(message)
    }

//        // indicate progress
//        observation = task.progress.observe(\.fractionCompleted) { progress, _ in
//            let t = Int(progress.fractionCompleted * 100)
//            // add a percentage label to display
//            DispatchQueue.main.async {
//                self.label.text = "\(t)%"
//            }
//        }

    task.resume()
}

// When syncing, update local data
func updateDownloadData() {
    let url = URL(string: "http://kitura-fall-2021.vm.duke.edu:5640/b64entries")
    guard let requestUrl = url else {
        fatalError()
    }

    var request = URLRequest(url: requestUrl)
    // set header
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Basic \(loginBase64)", forHTTPHeaderField: "Authorization")

    var jsonPersonList = [JSONPerson]()

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
            return
        }

        // status code
        if let response = response as? HTTPURLResponse {
            print("Status code: \(response.statusCode)")
        }

        // response body
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
//            print("Data string:\n\(dataString)")
            jsonPersonList = parseJSONPerson(data: data)!
        }

        var toSaveJSONPerson = JSONPerson.loadJSONPersonInfo()!
        for jsonPerson in jsonPersonList {
            toSaveJSONPerson[jsonPerson.netid] = jsonPerson
            let dukePerson = jsonPerson.getDukePerson()
            DataBase.dictionary[dukePerson.NetID] = dukePerson
        }

        // save to disk
        let _ = JSONPerson.saveJSONPersonInfo(toSaveJSONPerson)

        print("Update done.")
    }

//        // indicate progress
//        observation = task.progress.observe(\.fractionCompleted) { progress, _ in
//            let t = Int(progress.fractionCompleted * 100)
//            // add a percentage label to display
//            DispatchQueue.main.async {
//                self.label.text = "\(t)%"
//            }
//        }

    task.resume()
}

// do post
func postData() {
    let url = URL(string: "http://kitura-fall-2021.vm.duke.edu:5640/b64entries")
    guard let requestUrl = url else {
        fatalError()
    }

    var request = URLRequest(url: requestUrl)
    // set header
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Basic \(loginBase64)", forHTTPHeaderField: "Authorization")

    // change DukePerson to JSONPerson
    let dukePerson: DukePerson = DataBase.dictionary["cc749"]!
    // encode JSONPerson to JSON
    let jsonPerson = JSONPerson(dukeperson: dukePerson)
    request.httpBody = parseFromJSONPerson(jsonPerson: jsonPerson);

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
            return
        }

        // status code
        if let response = response as? HTTPURLResponse {
            print("Status code: \(response.statusCode)")
        }

        // response body
        if let data = data, let dataString = String(data: data, encoding: .utf8) {
//            print("Data string:\n \(dataString)")
        }

        print("Update done.")
    }
    task.resume()
}

// decode JSON to JSONPerson
func parseJSONPerson(data: Data) -> [JSONPerson]? {
    let decoder = JSONDecoder()
    var jsonPersonItems = [JSONPerson]()

    if let decoded = try? decoder.decode([JSONPerson].self, from: data) {
        jsonPersonItems = decoded
    }

    return jsonPersonItems
}

// encode a JSONPerson to JSON
func parseFromJSONPerson(jsonPerson: JSONPerson) -> Data {
    var outputData = Data()
    let encoder = JSONEncoder()
    
    if let encoded = try? encoder.encode(jsonPerson) {
        if let json = String(data: encoded, encoding: .utf8) {
            outputData = encoded
        }
    }
    
    return outputData
}
