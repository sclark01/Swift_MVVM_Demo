import UIKit
import Alamofire
import SwiftyJSON
import ReactiveCocoa
import ReactiveSwift

class PeopleListViewController: UIViewController{
    let peopleSignal = MutableProperty<[Person]>([])

    @IBOutlet weak var tableView: UITableView!

    var viewModel: PeopleListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = PeopleListViewModel(peopleService: PeopleService())

        self.title = viewModel.pageTitle
        peopleSignal <~ viewModel.people.producer

        let _ = peopleSignal.producer.startWithValues { _ in
            self.tableView.reloadData()
        }
    }

    func goToPersonDetailsView(withID id: Int) {
        let targetStoryboard = UIStoryboard(name: "PersonDetails", bundle: nil)
        guard let viewController = targetStoryboard.instantiateInitialViewController() as? PersonDetailsViewController else { return }
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle =  .crossDissolve
        viewController.personID = id
        pushViewControllerOntoNavigationController(withViewController: viewController, animated: true)
    }

    //allows the above logic to be tested by abstracting the untestable part
    func pushViewControllerOntoNavigationController(withViewController viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
}

extension PeopleListViewController : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPeople
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personForIndex = viewModel.getPersonAtIndex(indexPath.row)
        let cellIdentifier =  "cell"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)

        cell.textLabel?.text = personForIndex.name
        cell.detailTextLabel?.text = personForIndex.phone ?? ""
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let personID = viewModel.getPersonAtIndex(indexPath.row).id
        tableView.deselectRow(at: indexPath, animated: true)
        goToPersonDetailsView(withID: personID)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}



