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
}
