import Routing
import Vapor

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)


extension String {
    var asciiArray: [UInt32] {
        return unicodeScalars.filter{$0.isASCII}.map{$0.value}
    }
}

extension Character{
    var asciiValue: UInt32?{
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}


struct Input:Encodable,Content {
    var inList: [String]?
}

struct Output:Encodable,Content {
    let outList: [[String]]
}

func hashFunction(key: String)->Int{
    // Needs to take unique lowercase characters from a String and sum the ascii values of the lowercase letters.
    return 0
}


public func routes(_ router: Router) throws {
    
    
    router.post("hash") { req -> Input in
        
        // Put the post request content into our Input object
        let data = try req.content.decode(Input.self).await(on: req)
        let blankArray = [String]()
        var inList = Input(inList: blankArray)
        
        // This line
        for strings in (data.inList?.indices)!{
            inList.inList?.append(data.inList![strings])
        }
        
        for i in (inList.inList?.indices)!{
            inList.inList![i].map{$0.asciiValue}
        }
        
        print(inList.inList![0].asciiArray)
       
        
        
        return inList
        
        
    }

}
