//
//  WordListViewController.swift
//  VocabList
//
//  Created by Kaan Odabaş on 22.08.2023.
//

import UIKit

class WordListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var wordData: [[String: String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadWordDataFromGitHub()
        // Always adopt a light interface style.
        overrideUserInterfaceStyle = .light
    }
    
    func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WordCell")
        tableView.backgroundColor = UIColor(hex: 0xD9B4A3)
        // Always adopt a light interface style.
        overrideUserInterfaceStyle = .light
        
        view.addSubview(tableView)
    }
    
    func loadWordDataFromGitHub() {
        let url = URL(string: "https://raw.githubusercontent.com/kaanodabasx/englishwords/main/data.json")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if var words = json["words"] as? [[String: String]] {
                        // Verileri "english" değerine göre alfabetik olarak sırala
                        words.sort { (word1, word2) in
                            return word1["english"] ?? "" < word2["english"] ?? ""
                        }
                        self.wordData = words
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                } catch {
                    print("Error loading word data: \(error)")
                }
            }
        }.resume()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
        
        let word = wordData[indexPath.row]
        cell.textLabel?.text = "\(word["english"] ?? "") = \(word["turkish"] ?? "")"
        cell.detailTextLabel?.text = word["turkish"]
        cell.backgroundColor = UIColor(hex: 0xF1EEDB)
        
        return cell
    }
    
    func displayRandomWord() {
        // Gerekli işlemleri burada yapın
    }
}
