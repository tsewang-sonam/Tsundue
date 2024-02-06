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
        input.resignFirstResponder()
        // calls method to assign userinput value in view to control
    }

    @IBOutlet weak var output: UILabel!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
        input.backgroundColor = UIColor .lightGray
            input.addTarget(self, action: #selector(enterPressed), for: .editingDidEndOnExit)
        
        // Do any additional setup after loading the view.
            let imgLayout = UICollectionViewFlowLayout()
            imgLayout.itemSize = CGSize(width: 300.0, height: 300.0)
            //imgLayout.collectionView?.backgroundColor = UIColor.white
        let collectionOneImage = UICollectionView(frame: .zero, collectionViewLayout: imgLayout)
            
            collectionOneImage.register(PictureCollectionView.self, forCellWithReuseIdentifier: PictureCollectionView.id)
            collectionOneImage.dataSource = self
            view.addSubview(collectionOneImage)
            self.collectionOneImage = collectionOneImage
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            var collectionViewFrame = CGRect(x: 5, y: 400, width: self.view.frame.width - 10, height: self.view.frame.height - 150)
            collectionOneImage?.backgroundColor = UIColor.white

            if UIScreen.main.bounds.height <= 800{ // iPhone SE or smaller
                collectionViewFrame = CGRect(x: 5, y: 350, width: self.view.frame.width - 10, height: self.view.frame.height - 70)
            }

            collectionOneImage?.frame = collectionViewFrame
           
            //collectionOneImage?.frame = CGRect(x: 5, y: 400, width: self.view.frame.width - 10, height: self.view.frame.height - 150)
               
            
            // Adjust the frame of the collection view
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
        
    // This function fetches image from the unsplash API
    // We set Structs like responseFromAPi and url etc to retrieve the JSON data as in correct order
    // Note-To-Self :  changing the order of page,per_page or query etc results in error as it do not match the JSON format correctly
    
    func fetchPhoto( query : String) {
            
            print ("fetching :  " + query)
            // below after ? the kwywords like query, order_by,per_page are there to filter the images to get
            
            let urlString =
                "https://api.unsplash.com/search/photos?page=1&per_page=1&query=\(query)&client_id=ElAyf2yTSY6NS1LSaD_h6pZosQ8bswQrJUir5egH2eA"
            
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
        
       
        
        // This function helps to retrieve the word in tibetan from the dictionary txt
    
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
