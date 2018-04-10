import Routing
import Vapor
import Foundation

//Jean Cabral 001167363

extension String {
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
}
// Create a custom CharacterSet comprised of the lowercase values [a-z] and compare the elements in the strings to the elements in the set.

extension Character{
    var asciiValue: UInt32?{
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}

// Model For JSON Input
struct Input:Encodable,Content {
        var inList: [String]?
}

// Model for JSON Response
struct Output:Encodable,Content {
    let outList: [[String]]
}

/* This function takes a String and Returns an array of charcaters composed of the unique lowercase letters that were in the string.
 Ex: Input--> Boboi   : Output--> boi     Is Working!
 */

public func gimmeLowerCase(input: String)->String {
    
    let lowercaseLetters = input.lowercased()
    
    // let lowercaseLetters = input.filter {"abcdefghijklmnopqrstuvwxyz".contains($0)}
    var uniqueLowerCaseLetters = Set<Character>()
    
    for chars in lowercaseLetters.indices{
    uniqueLowerCaseLetters.insert(lowercaseLetters[chars])
    }
    
    let output = String(uniqueLowerCaseLetters)
    return output
}

public func createArrayAndAppend(element: String)-> [String]{
     var returnArray = [String]()
    
    returnArray.append(element)
    
    return returnArray
}


// Returns the HashValue of a String by summing the ASCII Values of the unique lowercase letters IS WORKING!
public func getHash(string: String)-> Int {
    var tempArray = [UInt32]()
    tempArray = gimmeLowerCase(input: string).asciiArray
    let sum = tempArray.reduce(0,+)
    return Int(sum)
}


public func routes(_ router: Router) throws {
    
    
    router.post("hash") { req -> Output in
        
        // Put the post request content into our Input object
        let data = try req.content.decode(Input.self).await(on: req)
        let blankArray = [String]()
        var input = Input(inList: blankArray)
        
        // Holds the Hashes
        var keyArray = [Int]()
       
        // Remove the duplicate values from the array.
        
        
        // Creates a New Input Object and gives it the value of the Respons
        for strings in (data.inList?.indices)!{
            input.inList?.append(data.inList![strings])
        }
        
        
        // Array to give our OutList Object
        var outputArray = [[String]]()
       
        // Adds the hashes to the array
        for i in (input.inList?.indices)!{
         keyArray.append(getHash(string: input.inList![i]))
            }
        // Reverse the order
        keyArray.reverse()
        
        let duplicates = Array(Set(keyArray.filter({ (i: Int) in keyArray.filter({ $0 == i }).count > 1})))
        print(duplicates)
        
        
        
        for i in (input.inList?.indices)!{
            if(duplicates.contains(getHash(string: input.inList![i]))){
              outputArray.append(createArrayAndAppend(element:input.inList![i]))
            }
        }
        
        var newOutputArray = [[String]]()
        
        
        for j in outputArray.indices{
            
        }
    
        
        
        
        print(keyArray)
        //outputArray.append(createArrayAndAppend(element:))
        let out = Output(outList: outputArray)
        
        return out
        }
        
    
        
    }



//stringArray.append(dictionary[getHash(string:gimmeLowerCase(input: input.inList![strings]))] as! String)
