//
//  CharactersListViewCell.swift
//  BreakingBad
//
//  Created by Артур Сахбиев on 27.05.2022.
//

import UIKit

class CharactersListViewCell: UITableViewCell {

    @IBOutlet var photoChar: UIImageView!
    @IBOutlet var descriptionChar: UILabel!
    
    /*
    func configure(with character: Characters){
        descriptionChar.text = character.name
        
        DispatchQueue.global().async {
            guard let url = URL(string: character.img ?? "" ) else {return}
            guard let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.photoChar.image = UIImage(data: imageData)
                self.photoChar.layer.cornerRadius = self.photoChar.frame.height / 2

            }
        }
    }
     */
    
    func configureAF(with character: Characters){
        photoChar.layer.cornerRadius = 10
        descriptionChar.text = character.name
        
        NetworkManager.shared.fetchImageAF(with: character) { result in
            switch result {
            case .success(let imageDate):
                DispatchQueue.main.async {
                    self.photoChar.image = UIImage(data: imageDate)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
