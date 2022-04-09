import Foundation

class CatView{
    static let instance:CatView = CatView()
    let catPresenter:CatPresenter = CatPresenter.instance

    func start(){
        catPresenter.loadBreeds()
        viewMainMenu()
    }

    func viewMainMenu(){
        print("Welcome to TheApiCat\n1.Initial letters of Breeds\n2.Breeds Library\n3.The Cat Breed Battle\n4.Exit")

        switch readLine()! {
        case "1":
                InitialLettersOfTheBreeds()
                viewSearchBreed()
                goBackSystemMainMenuView()
        case "2":
                showBreedsLibrary()
        case "3":
                votesView()
        default:
           print("bye..bye =D")
           cleanConsole()
        }
    }

    func cleanConsole(){
        print("\u{1B}[1;1H", "\u{1B}[2J")
    }

    func showBreedsLibrary(){
        let cats = catPresenter.getCats()
        for cat  in cats {
            print("\(cat.nameBreed) -> origin: \(cat.originBreed)" )  
        }
    }

    func InitialLettersOfTheBreeds(){
        let letters = catPresenter.getinitialLetterBreeds()
        for letter  in letters {
            print(letter)
        }
    }

    func viewSearchBreed(){

        print("Select a letter")
        let letterSelected = Character(readLine()!.uppercased())
        let cats = catPresenter.getCatInitialsLetter(letterSelected:letterSelected)

        if !(cats.isEmpty == false) {
            print("There are no breeds with this initial")
            goBackSystemMainMenuView()
        }else{

            showBreedsbySlectedLetter(cats)
            showDescriptionOfBreed(cats:cats)
            
        }
        goBackSystemMainMenuView()
 
    }
    //
    func votesView(){
            cleanConsole()
            print("The Cat Breed Battle\n1.Vote\n2.Voted List\n3.Breeds\n4.Back")

            switch readLine()! {
                case "1":
                    viewVoting()
                case "2":
                    votesRecord()
                case "3":
                    InitialLettersOfTheBreeds()
                    viewSearchBreed()
                default:
                    goBackSystemMainMenuView()
            }
    }

    func viewVoting(){

        var exit:Bool = true
        repeat{
            let cat = catPresenter.ramdomBreed()
            cleanConsole()
            print("******************** The Cat Breed Battle *******************")
            print("Breed Name: \(cat.nameBreed)")
            print("Selected Option\n1.Like\n2.Dislike\n3.Leave")
            switch Int(readLine()!) {
                case 1:
                    catPresenter.setVotes(cat:cat, vote:1)
                case 2:
                    catPresenter.setVotes(cat:cat , vote: 0)
                default:
                    exit = false   
            }
        }while exit    
        goBackSystemVotesView() 
    }

    func votesRecord (){
        cleanConsole()
        let cats = catPresenter.getCats()

        if let votes = catPresenter.getVotes(){
            var votesLike = 0 , votesDislike = 0
                for cat in cats {
                    for vote in votes.breeds{
                        if(vote.nameBreed == cat.nameBreed ){
                            if vote.like == "1" {
                                votesLike += 1
                            }
                            else if vote.disLike == "0" {
                                votesDislike += 1
                            }
                        }  
                    }
                if(votesDislike != 0 || votesLike != 0){
                    print("Breed: \(cat.nameBreed)\nLike: \(votesLike)\nDislike:\(votesDislike)")
                    votesLike = 0 
                    votesDislike = 0
                    print("***********************************")
                    }
                }     
        }
        goBackSystemVotesView()
    }

    func showDescriptionOfBreed(cats:[UICat]){
         print("Number the Breed")
        let numberCat = Int(readLine()!)!
        let cat = cats[numberCat-1]
        let totalCatsFound = cats.count
        if numberCat >= 1 && numberCat < totalCatsFound{
              print("Breeds Name: \(cat.nameBreed)\nDescription:\(cat.descriptionBreed)")
        }else{
            print("does not exist")
        }
        goBackSystemMainMenuView()
    }

    func valuOpcion(opcion:String)-> Bool{
        if(opcion.uppercased() == "Y"){
            return true
        }
        return false
    }

    func goBackSystemVotesView(){
        readLine()
        print("Go back?\nY: yes\nN: not")
        let opcion = readLine()!
        if (valuOpcion(opcion:opcion)){
             cleanConsole()
             votesView()
         }
    }

    func showBreedsbySlectedLetter(_ cats:[UICat]){
        var numberBreeds = 1
        print("selected opcion")
        for cat in cats {
            print("\(numberBreeds). \(cat.nameBreed)")
            numberBreeds += 1
        }
    }

    func goBackSystemMainMenuView(){
        readLine()
        print("Go back?\nY: yes\nN: not")
        let opcion = readLine()!
        if (valuOpcion(opcion:opcion)){
             cleanConsole()
             viewMainMenu()
         }
    }

}