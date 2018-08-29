/**
 * Контроллер списки сомпьютеров
 */

import UIKit
import Alamofire

class ListComputerTableViewController: UITableViewController{
    
    // Фабрика запросов
    let computersRequests: ComputersRequestFactory
        = RequestFactory().makeComputersRequestFactory()
    
    var computers: [ComputerResult] = [] {
        didSet {
            self.updateUI()
        }
    }
    
    var pageNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillToolbar()
        fetchPage()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return computers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "computerCell", for: indexPath)
        
        let computer = computers[indexPath.row]
        
        cell.textLabel?.text = computer.name
        cell.detailTextLabel?.text = computer.company?.name
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let computerID = computers[indexPath.row].computerID
        // Билдер контроллера компьютера
        let computerBuilder = ComputerDefaultBuilder(computerID: computerID)
    
        navigationController?.pushViewController(computerBuilder.build(), animated: true)
        
    }
    

    //  Обновление интерфейса
    func updateUI() {
        DispatchQueue.main.async {
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .automatic) 
        }
    }
    //  Получение данных для загрузки страницы
    func fetchPage() {
        if (pageNumber <= 0) {
            pageNumber = 1
            return
        }
        computersRequests.getListComputer(pageNumber: pageNumber) { response in
            switch response.result {
            case .success(let value):
                self.computers = value.items
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

}

