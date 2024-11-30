//
//  APIRequest.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-21.
//

import Foundation


class APIRequest
{
    struct Test: Codable {
    let session: String
    }
    typealias Parameters = [String: String]
    
    func Post(withParameters params: [String:String],_url:String = "https://www.wavetoget.ca/api2/index.php",completion: @escaping (String)->())
    {
        var html = ""
        var parameters = [                      "key":"C3E8A9DD46D48B35815A63A516F10B9A4B8DA37819E6D28F556E42ABE20DB641333C108F6CDBBC26EF64F6314369586F5151F5377E1AECDB956C6F5D13F08067"]
        
        parameters.merge(params){ (current, _) in current }
        print(parameters)
        
        guard let url = URL(string: _url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = generateBoundary()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("​application/json", forHTTPHeaderField: "Content-Type")

        
        let dataBody = createDataBody(withParameters: parameters, boundary: boundary)
        request.httpBody = dataBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
//                do {
                    html = String(data:data, encoding: .utf8)!
                //print(html)
                completion(html)
                    //let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
//                } catch {
//                    print(error)
//                }
            }
            }.resume()
    }
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createDataBody(withParameters params: Parameters?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }
        
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
}


extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
