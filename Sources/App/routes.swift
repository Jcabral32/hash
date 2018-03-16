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
// Add the HashSet Code
public struct HashSet<T: Hashable> {
    private var dictionary = Dictionary<T, Bool>()
    
    public mutating func insert(element: T) {
        dictionary[element] = true
    }
    
    public mutating func remove(element: T) {
        dictionary[element] = nil
    }
    
    public func contains(element: T) -> Bool {
        return dictionary[element] != nil
    }
    
    public func allElements() -> [T] {
        return Array(dictionary.keys)
    }
    
    public var count: Int {
        return dictionary.count
    }
    
    public var isEmpty: Bool {
        return dictionary.isEmpty
    }
}

extension HashSet {
    public func union(otherSet: HashSet<T>) -> HashSet<T> {
        var combined = HashSet<T>()
        for obj in dictionary.keys {
            combined.insert(element: obj)
        }
        for obj in otherSet.dictionary.keys {
            combined.insert(element: obj)
        }
        return combined
    }
    
    public func intersect(otherSet: HashSet<T>) -> HashSet<T> {
        var common = HashSet<T>()
        for obj in dictionary.keys {
            if otherSet.contains(element: obj) {
                common.insert(element: obj)
            }
        }
        return common
    }
    
    public func difference(otherSet: HashSet<T>) -> HashSet<T> {
        var diff = HashSet<T>()
        for obj in dictionary.keys {
            if !otherSet.contains(element: obj) {
                diff.insert(element: obj)
            }
        }
        return diff
    }
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
