//
//  NetworkManager.swift
//  BreakingBad
//
//  Created by Артур Сахбиев on 27.05.2022.
//

import Foundation
import UIKit
import Alamofire

enum NetworkError: Error {
  case badURL
  case invalidData
  case decodeError
}

struct NetworkManager {
    static let shared = NetworkManager()
    private let urlString = "https://www.breakingbadapi.com/api/characters"
    
    private init() {}
    
    func fetchCharacter(completionHandler: @escaping(Result <[Characters], NetworkError>) -> Void){
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                completionHandler(.failure(.invalidData))
                return
            }
            
            do{
                let character = try JSONDecoder().decode([Characters].self, from: data)
                completionHandler(.success(character))
            } catch let error {
                print(error)
                completionHandler(.failure(.decodeError))
            }
        }.resume()
    }
    
    func fetchImage(with character: Characters ,
                    completionHandler: @escaping(Result <Data, NetworkError>) -> Void){
        DispatchQueue.global().async {
            guard let url = URL(string: character.img ?? "") else {
                completionHandler(.failure(.badURL))
                return
            }
            if let imageData = try? Data(contentsOf: url){
                completionHandler(.success(imageData))
                return
            }else {
                completionHandler(.failure(.invalidData))
                return
            }
        }
    }
    
    func fetchCharactersWithAlamofire(completion: @escaping(Result<[Characters], NetworkError>) -> Void){
        AF.request(urlString)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let characters = Characters.getCharacters(from: value)
                    DispatchQueue.main.async {
                        completion(.success(characters))
                    }
                case .failure:
                    completion(.failure(.decodeError))
                }
            }
    }
}
