import UIKit
import SwiftyJSON
import ReactiveCocoa
import ReactiveSwift

class PeopleListViewModel {
    let people = MutableProperty<[Person]>([])
    let peopleService: PeopleServiceType

    init(peopleService: PeopleServiceType) {
        self.peopleService = peopleService
        peopleService.getAllPeopleWithDetails { people in
            self.people.value = people
        }
    }

    var numberOfPeople: Int {
        return people.value.count
    }

    var pageTitle: String {
        return "Contacts"
    }

    func getPersonAtIndex(_ index: Int) -> Person {
        return people.value[index]
    }
}
