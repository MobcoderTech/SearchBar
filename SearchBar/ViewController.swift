//
//  ViewController.swift
//  SearchBar
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar:UISearchBar!
    @IBOutlet weak var tableView:UITableView!

    let dataSource = ["First","Second","Third","Fourth","Fifth","Sixth"]
    var searchedArry = [String]()
    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController:UISearchBarDelegate{

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false;
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchedArry = dataSource.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of:searchText, options:.caseInsensitive)
            return range.location != NSNotFound
        })
        if(searchedArry.count == 0){
            isSearching = false;
        } else {
            isSearching = true;
        }
        self.tableView.reloadData()
    }
}

extension ViewController:UITableViewDataSource,UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearching) {
            return searchedArry.count
        }
        return dataSource.count;
    }

    func tableView(_ cellForRowAttableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        if(isSearching){
            cell.textLabel?.text = searchedArry[indexPath.row]
        } else {
            cell.textLabel?.text = dataSource[indexPath.row];
        }

        return cell;
    }
}
