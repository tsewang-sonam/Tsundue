//
//  SearchViewController.swift
//  mockapp
//
//  Created by tsewang sonam on 4/28/23.
//

import UIKit




 
    struct reponseFromApi: Codable {
        let total : Int
        let total_pages: Int
        let results: [Result]
    }

    struct Result: Codable {
        let id : String
        let urls: URLS
    }
    struct URLS: Codable {
        let small: String
    }

    struct wordSearch {
        let prompt: String
        let answer: String
    }

class SearchViewController: UIViewController,UICollectionViewDataSource {
       
    private var collectionOneImage:UICollectionView?
        
        var results: [Result] = []
      
       

    
    @IBOutlet weak var input: UITextField!
    
    @IBAction func enterPressed(_ sender: Any) {
        guard let value = input.text else { return }
        inputValue(userInput: value)
        // calls method to assign userinput value in view to control
    }

    @IBOutlet weak var output: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            let imgLayout = UICollectionViewFlowLayout()
            imgLayout.itemSize = CGSize(width: 300.0, height: 300.0)
            let collectionOneImage = UICollectionView(frame: .zero, collectionViewLayout: imgLayout)
            
            collectionOneImage.register(PictureCollectionView.self, forCellWithReuseIdentifier: PictureCollectionView.id)
            collectionOneImage.dataSource = self
            view.addSubview(collectionOneImage)
            self.collectionOneImage = collectionOneImage
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            collectionOneImage?.frame = CGRect(x: 5, y: 450, width: self.view.frame.width, height: self.view.frame.height)
            output.font = UIFont.systemFont(ofSize: 45)
            output.font = UIFont.boldSystemFont(ofSize: 50)
            
        }
    
    func inputValue(userInput: String)  {
        
        // pass the userInput (eg. apple ) to getDataFromFile function
        
        if getDataFromFile(word: userInput){
            fetchPhoto(query: userInput)
        }else{
            fetchPhoto(query: " ")
            output.text = " No Result "
        }
    }
        
        func fetchPhoto( query : String) {
            
            print (" Fetching")
            // below after ? the kwywords like query, order_by,per_page are there to filter the images to get
            
            let urlString = "https://api.unsplash.com/search/photos?query=\(query)&order_by=popular&per_page=1&client_id=ElAyf2yTSY6NS1LSaD_h6pZosQ8bswQrJUir5egH2eA"
            
            guard let url = URL (string: urlString) else {
                return
            }
            
            // this part fetch the data from api and decode the output of the API
            let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
                guard let data = data, error == nil  else {
                    return
                }
                do{
                    let jsonOutput = try JSONDecoder().decode(reponseFromApi.self, from: data)
                    DispatchQueue.main.async {
                        self?.results = jsonOutput.results
                        self?.collectionOneImage?.reloadData()
                    }
                }catch {
                    print(error)
                }
            }
            
        task.resume()
        }
        
       
        
        
        func getDataFromFile(word: String) -> Bool {
            
            print (" In txt " + word)
            var keyValue : [String] = []    // array to store values in file
            
            guard let fileUrlDictionary = Bundle.main.path(forResource: "dictionary", ofType: "txt") else {return false}
            var readStringDictionary = ""
            do {
                readStringDictionary = try String(contentsOfFile: fileUrlDictionary, encoding: String.Encoding.utf8)
                keyValue = readStringDictionary.components(separatedBy: "\n")    // stores the data in txt to array line by line
                
                var num = 0               // to keep track of array value of the word
                for line in keyValue {
                    if !keyValue.isEmpty {
                        let firstWord = line.components(separatedBy: " ").first ?? ""       // retrieving the first word in line
                        if(firstWord.lowercased() == word.lowercased()) {     // checking if userinput and data in txt are same
                            
                            var hi = keyValue[num]
                            if let range = hi.range(of: firstWord) {
                               hi.removeSubrange(range)                  // removing the word and showing the tibetan word
                                print(hi)
                            }
                           output.text = hi
                            return true
                        }
                        num += 1
                    }
                  
            }

            } catch let error as NSError{
                print("failed to read from Dictionary")
                print(error)
            }
            
           return false
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            print (" In collection ")
            return results.count

        }
        
        func  collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let apiImgUrl = results[indexPath.row].urls.small
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionView.id, for: indexPath) as? PictureCollectionView else{
                return UICollectionViewCell()
            }
            cell.configure(with: apiImgUrl)
            print (" In collection 2")
            return cell
        }
}
