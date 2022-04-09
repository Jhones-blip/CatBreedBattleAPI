import Foundation

typealias CallbackBlock <T:Any> = (_ value:[T])->Void
let converterUICat:CatUIConverter = CatUIConverter()
let converterUIVote:VoteUIConverter = VoteUIConverter()

struct CatBreedsStatus:Codable{
    var breeds: [Vote] = []
}


class CatPresenter{
   
    static let instance:CatPresenter = CatPresenter()
    let dataService:CatDataService = CatDataService.instance
    var catBreedsStatus = CatBreedsStatus()
    var cats:[UICat] = []
    var votes:[Vote] = []

    var initialLetterBreeds = [Character]()

    func loadBreeds(){
        dataService.getBreeds(onCompletion:{
                cats in self.addBreedLibrary(converterUICat.convert(cats))
        })
    }
    
    func setVotes(cat:UICat, vote:Int){
        if vote == 1 {

            self.catBreedsStatus.breeds.append(Vote(nameBreed:cat.nameBreed,like:"1",disLike:"0"))
            dataService.saveBreedsVoting(catBreedsStatus)
           
        }else{
            self.catBreedsStatus.breeds.append(Vote(nameBreed:cat.nameBreed,like:"0",disLike:"0"))
            dataService.saveBreedsVoting(catBreedsStatus)
        }
    }

    func getVotes() -> CatBreedsStatus? {
        return dataService.getSavedVoting()
    }

    func getCats()-> Array<UICat>{
        return self.cats
    }

    func addBreedLibrary(_ cats:[UICat]){
        self.cats = cats
        addInitialLetterBreeds(cats)
    }

    func numberBreedsInLibrary() -> Int{
        return cats.count
    }

    func addInitialLetterBreeds(_ cats:[UICat]){
        let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var initialLetterBreed:Character

        for letter in alphabet {
            for cat in self.cats{  
                initialLetterBreed = letterInitial(sentence:cat.nameBreed  )
                if letter == initialLetterBreed{
                   self.initialLetterBreeds.append(letter)
                   break     
                }
            }
        }
    }

    func getinitialLetterBreeds() -> Array<Character>{
        return self.initialLetterBreeds
    }

    func letterInitial(sentence:String)->Character{
        return Character(String(sentence[sentence.startIndex]))
    }

    func getCatInitialsLetter(letterSelected:Character) -> Array<UICat>{

        var breedsFilter = [UICat]()
        var initialLetterBreed:Character

        for cat in self.cats {
            initialLetterBreed = letterInitial(sentence:cat.nameBreed)
            if initialLetterBreed == letterSelected {
                breedsFilter.append(cat)
            }
        }

        return breedsFilter
    }


    func ramdonNumber()-> Int{
        let numberMax: Int  = self.cats.count
        return Int.random(in: 1..<numberMax)
    }

    func ramdomBreed() -> UICat {
        return self.cats[ramdonNumber()]
    } 

}