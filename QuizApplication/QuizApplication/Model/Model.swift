//
//  Model.swift
//  QuizApplication
//
//  Created by IPS-161 on 16/06/23.
//

import Foundation
import SwiftUI

// MARK: - QuizModel
struct QuizModel: Codable {
    let difficulty: Int
    let quiz: [Quiz]
}

// MARK: - Quiz
struct Quiz: Codable {
    let questionTitle, option1, option2, option3: String?
    let option4, correctAns: String?
}


class QuizModelClass : ObservableObject {
    
    @Published  var quizModelArray = [QuizModel]()
    @Published  var dismiss = false
    
    init(){
        
        fetchData { data in
            self.quizModelArray = data
        }
    }
    
    
    func fetchData(completion: @escaping ([QuizModel]) -> ()){
        if let url = URL(string:"https://raw.githubusercontent.com/DarshanMagare2001/QuizAppApi/main/QuizAppApi.json"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    
                    if let safeData = data{
                        
                        let str = String(decoding: safeData, as: UTF8.self)
                        //                        print(str)
                        do{
                            let results =   try  decoder.decode([QuizModel].self , from: safeData)
                            
                            completion(results)
                        } catch{
                            print(error)
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    
}
