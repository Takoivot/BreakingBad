//
//  CharactersViewController.swift
//  BreakingBad
//
//  Created by Артур Сахбиев on 27.05.2022.
//

import UIKit

class CharactersViewController: UITableViewController {
    
    let url = "https://www.breakingbadapi.com/api/characters"
    
    var characters: [Characters] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bad", for: indexPath) as! CharactersListViewCell
        let character = characters[indexPath.row]
        cell.configure(with: character)

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let fullInfoVC = segue.destination as? FullInfoViewController else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let character = characters[indexPath.row]
        fullInfoVC.character = character
    }
  

}

extension CharactersViewController {
    private func fetchCharacters() {
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                self.characters = try JSONDecoder().decode([Characters].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
            }catch let error {
                print(error)
            }
        }.resume()
    }
}
