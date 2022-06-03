//
//  Characters.swift
//  BreakingBad
//
//  Created by Артур Сахбиев on 27.05.2022.
//

import Foundation

struct Characters: Decodable {
    let char_id: Int?
    let name: String?
    let nickname: String?
    let img: String?
    let portrayed: String?
    var description: String {
        """
        Name: \(name ?? "unknown")
        Nick name: \(nickname ?? "unknown")
        Actor name: \(portrayed ?? "unknown")
        """
    }
    
    init(characterDate: [String : Any]) {
        char_id = characterDate["char_id"] as? Int
        name = characterDate["name"] as? String
        nickname = characterDate["nickname"] as? String
        img = characterDate["img"] as? String
        portrayed = characterDate["portrayed"] as? String
    }
    
    static func getCharacters(from value: Any) -> [Characters] {
        guard let charactersDate = value as? [[String : Any]] else {return []}
        return charactersDate.compactMap {Characters(characterDate: $0)}
    }
}
