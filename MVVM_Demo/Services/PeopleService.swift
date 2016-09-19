import Foundation
import Alamofire
import SwiftyJSON

protocol PeopleServiceType {
    func getAllPeople(onCompletion: ([Person]) -> Void)
    func getPersonByID(withID id: Int, onCompletion: (Person) -> Void)
    func getAllPeopleWithDetails(onCompletion:([Person])-> Void)
}

class PeopleService : PeopleServiceType {

    func getAllPeople(onCompletion: ([Person]) -> Void) {
        Alamofire
            .request(.GET, "http://localhost:8000/list")
            .validate(statusCode: 200..<400)
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    let people = PeopleTransformer.transformListOfPeople(json)
                    onCompletion(people)
                }
        }
    }

    func getPersonByID(withID id: Int, onCompletion: (Person) -> Void) {
        Alamofire
            .request(.GET, "http://localhost:8000/personByID?id=\(id)")
            .validate(statusCode: 200..<400)
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    let people = PeopleTransformer.transformListOfPeople(json)
                    onCompletion(people.first ?? Person(id: -1, name: ""))
                }
        }
    }
    func getAllPeopleWithDetails(onCompletion:([Person])-> Void) {
        Alamofire
            .request(.GET, "http://localhost:8000/listAll")
            .validate(statusCode: 200..<400)
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    let people = PeopleTransformer.transformListOfPeople(json)
                    onCompletion(people)
                }
        }
    }
}