import Foundation

@testable import MVVM_Demo

class PeopleServiceMock: PeopleServiceType {
    var getAllPeopleCalled = false
    var getPersonByIDCalled = false
    var didCallPersonByIDWithID: Int?
    var getAllPeopleWithDetailsCalled = false
    var stubbedPeopleWithoutDetail = [Person(id: 1, name: "someName")]
    var stubbedPerson = Person(id: 0, name: "someName", age: 10, phone: "somePhone")

    func getAllPeople(_ onCompletion: @escaping ([Person]) -> Void){
        getAllPeopleCalled = true
        onCompletion(stubbedPeopleWithoutDetail)
    }

    func getPersonByID(withID id: Int, onCompletion: @escaping (Person) -> Void) {
        getPersonByIDCalled = true
        didCallPersonByIDWithID = id
        onCompletion(stubbedPerson)
    }
    
    func getAllPeopleWithDetails(_ onCompletion: @escaping ([Person])-> Void) {
        getAllPeopleWithDetailsCalled = true
        onCompletion(stubbedPeopleWithoutDetail)
    }
}
