//
//  ViewController.swift
//  BreakingBad
//
//  Created by Артур Сахбиев on 27.05.2022.
//

import UIKit

class FullInfoViewController: UIViewController {
    
    var character: Characters!

    @IBOutlet var photoCharacter: UIImageView!
    @IBOutlet var descriptionCharacter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

extension FullInfoViewController{
    func configure(){
        descriptionCharacter.text = character.description
        DispatchQueue.global().async {
            guard let url = URL(string: self.character.img ?? "") else {return}
            guard let imageData = try? Data(contentsOf: url) else {return}
            DispatchQueue.main.async {
                self.photoCharacter.image = UIImage(data: imageData)
            }
        }
    }
}

