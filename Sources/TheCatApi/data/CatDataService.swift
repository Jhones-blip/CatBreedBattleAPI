
import Foundation
import FoundationNetworking

class CatDataService{
    
    static let instance:CatDataService = CatDataService()
    let catApiToken = "b31e3cf7-0b06-49c0-bb3b-cc1eaf8561c0"
    let defaults = UserDefaults.standard

    func getBreeds(onCompletion:@escaping CallbackBlock<Cat> ){
        
        let url = URL(string: "https://api.thecatapi.com/v1/breeds")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request){data , response, error in 
                guard let data = data else { return }
                do {
                    let decodeData : [Cat] = try JSONDecoder().decode([Cat].self, from: data)
                        onCompletion(decodeData)

                } catch {
                    print("******* Faild *********")
                    print(error)

                }
        }
        task.resume()
    } 

    func saveBreedsVoting(_ catBreeds:CatBreedsStatus){
        if let encoded = try?JSONEncoder().encode(catBreeds){
            defaults.set(encoded,forKey: "saveSession")
        }
    }

    func getSaveVoting() -> CatBreedsStatus? {
        if let saveSession = defaults.object(forKey: "saveSession") as? Data{
            if let loadedSession = try?JSONDecoder().decode(CatBreedsStatus.self, from: saveSession){
                return loadedSession
            }
        }
        return nil 
    }
    
}

