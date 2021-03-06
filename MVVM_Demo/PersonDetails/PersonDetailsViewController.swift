import UIKit
import ReactiveCocoa
import ReactiveSwift

class PersonDetailsViewController : UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    var viewModel: PersonDetailsViewModel!
    let personSignal = MutableProperty<Person?>(nil)
    var peopleService: PeopleServiceType = PeopleService()

    var personID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewModel()
        self.title = viewModel?.pageTitle
    }

    func setUpViewModel() {
        guard let id = personID else { return }
        viewModel = PersonDetailsViewModel(withID: id, peopleService: peopleService)
        personSignal <~ viewModel.person.producer

        let _ = personSignal.producer.startWithValues {[weak self] _ in
            self?.updateLabels()
        }
    }

    func updateLabels() {
        nameLabel.text = viewModel.name
        phoneLabel.text = viewModel.phone
        ageLabel.text = viewModel.age
    }
}
