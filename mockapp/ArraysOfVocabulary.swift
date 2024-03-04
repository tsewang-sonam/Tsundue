//
//  ArraysOfVocabulary.swift
//  mockapp
//
//  Created by tsewang sonam on 5/12/23.
//



class ArraysOfVocabulary {
    
    
    private var tableDictionary: [String: [String]] = [:]

        init() {
            // Initialize your tables here
        
            
            tableDictionary["animal"] = ["goat", "cow", "mouse", "monkey", "dog", "rabbit","pig","cat", "bird","sheep","horse"]
            tableDictionary["colors"] = ["blue", "red", "black","green","yellow","white","orange","pink","purple","brown","navy"]
            tableDictionary["countries"] = ["tibet","india","nepal","china","mongolia", "japan","america","bhutan","france","germany"]
            tableDictionary["vegetables"] = ["potato","onion","carrot","spinach","tomatoes","corn","turnip","garlic","beans","mushroom","cabbage"]
            tableDictionary["days"] = ["sunday","monday","tuesday","wednesday","thursday","friday","saturday","holidays","birthday","weekend","weekdays"]
            tableDictionary["nature"] = ["mountain","tree","ocean","lake","cloud","wind","ice","rain","snow","river","rock"]
            tableDictionary["school"] =
                ["student","teacher","book","pen","classroom","pencil","bag","library","textbook","ink"]
            tableDictionary["kitchen"] =
                ["stove","fridge","cup","plate","spoon","knives","utensils","stranier","plate","thermostat","spices"]
            tableDictionary["ingredients"] =
                ["salt","pepper","garlic","ginger","chilli","spices","egg","cooking_oil","yeast","flour","rice"]
            tableDictionary["clothes"] =
                ["hat","pants","shoes","socks", "shirt", "coat", "scarf","sweater","gloves","sandal"]
            // Add more tables as needed
        }
    

    
        func getTable(named tableName: String) -> [String]? {
            return tableDictionary[tableName]
        }
    

        // Do any additional setup after loading the view.
    }
    
    
    

