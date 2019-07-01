import UIKit

//Holds an image BEFORE it becomes a UI Image that can be displayed
struct Image: Decodable {
    
    //tells which kind of image it is
    enum Kind: String, Decodable {
        case scene
        case sticker
    }
    
    enum DecodingError: Error {
        case missingFile
    }
    
    //init
    let name: String
    let kind: Kind
    let pngData: Data
}

//Extending arrays that hold image elements
extension Array where Element == Image {
    //new initializer for an array
    init(fileName: String) throws {
        //gets the URL safely and thows the missingFile error is it can't find it
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw Image.DecodingError.missingFile
        }
        
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        self = try decoder.decode([Image].self, from: data)
    }
}

let images = try [Image](fileName: "images")
images.map { UIImage(data: $0.pngData) }

