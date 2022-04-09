import Foundation

struct UICat {
    let nameBreed:String
    let originBreed:String
    let imageId:String
    let descriptionBreed:String
}


class CatUIConverter{

    func convert (_ cats:[Cat]) -> [UICat] {

        return cats.map({cat in
            return convertCat(cat)
        })
        
    }

    func convertCat(_ cat:Cat ) -> UICat{

        let nameBreed = cat.name
        let originBreed = cat.origin
        let imageId = cat.reference_image_id ?? ""
        let descriptionBreed = cat.description

        return UICat(nameBreed:nameBreed,originBreed:originBreed,imageId:imageId,
                    descriptionBreed:descriptionBreed)

    }

}
