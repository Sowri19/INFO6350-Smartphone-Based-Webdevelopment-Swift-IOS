//
//  CompnayTableViewController.swift
//  UsingStoryBoard


import UIKit
import CoreData

class CompanyTableViewController: UITableViewController, CompanyViewControllerDelegate {
    
    weak var delegate: CompanyViewControllerDelegate?
    var Companies: [CompanyData] = [] // Define productTypes as an array of Companies objects
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch companies from CoreData
        fetchCompanies()
        // Register the cell class with the table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        // Reload table view to display fetched data
        tableView.reloadData()
        // Configure search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Companies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    func fetchCompanies(with searchText: String? = nil) {
        // Fetch request for Company entity
        let fetchRequest: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
        
        // Add a predicate to filter the results based on the search text
        if let searchText = searchText, !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        }
        
        do {
            // Fetch companies from CoreData
            Companies = try context.fetch(fetchRequest)
            
            // Reload table view to display fetched data
            tableView.reloadData()
        } catch {
            print("Error fetching companies: \(error.localizedDescription)")
        }
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Companies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let company = Companies[indexPath.row]
        
        // Set the company name as the cell's text label
        cell.textLabel?.text = company.name
        
        // Set the company ID as the cell's detail text label
        cell.detailTextLabel?.text = String(company.id)
        
        // Convert the binary data of the logo attribute to a UIImage object
        if let logoData = company.logo {
            if let logoImage = UIImage(data: logoData) {
                // Set the logo image as the cell's image view
                cell.imageView?.image = logoImage
            }
        } else {
            // Handle case where logo data is nil, e.g., display a placeholder image or hide the image view
            cell.imageView?.image = nil
        }
        // Configure the appearance of the logo in the cell's image view
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        
        // Add a details disclosure button
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected company from the companies array
        let selectedCompany = Companies[indexPath.row]

        // Perform segue to CompanyDetailsViewController with the selected company
        performSegue(withIdentifier: "showCompanyDetails", sender: selectedCompany)
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // Get the selected company from the companies array
        let selectedCompany = Companies[indexPath.row]

        // Perform segue to CompanyDetailsViewController with the selected company
        performSegue(withIdentifier: "showCompanyDetails", sender: selectedCompany)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCompanyDetails" {
            if let companyDetailsVC = segue.destination as? CompanyDetailsViewController {
                if let selectedCompany = sender as? CompanyData {
                    // Pass the selectedCompany object to CompanyDetailsViewController
                    companyDetailsVC.Company = selectedCompany
                }
            }
        } else if segue.identifier == "addcompany" {
            if let addCompanyVC = segue.destination as? CompanyViewController {
                addCompanyVC.delegate = self
            }
        }else if segue.identifier == "updatecompany" {
            if let updateCompanyVC = segue.destination as? CompanyViewController {
                updateCompanyVC.delegate = self
            }
        }
    }

    func didAddCompany(Company: CompanyData) {
        // Append the newly added company to the companies array
        Companies.append(Company)

        // Reload the table view to display the new data
        tableView.reloadData()
    }
    func didUpdateCompany(Company: CompanyData) {
        // Update the product type in your data source
        // Reload the table view to display the updated data
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Get the selected company from the companies array
            let selectedCompany = Companies[indexPath.row]
            let companyId = selectedCompany.id // Assuming 'id' is the property that represents the company ID

            // Check if any product posts are associated with this company
            let productPostFetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
            productPostFetchRequest.predicate = NSPredicate(format: "company_id == %ld", companyId)
            do {
                let productPosts = try context.fetch(productPostFetchRequest)
                if !productPosts.isEmpty {
                    let alert = UIAlertController(title: "Error", message: "There are product posts associated with this company id. Please disassociate or delete them before deleting the company.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            } catch let error {
                // Handle any errors that occur during fetch
                let alert = UIAlertController(title: "Error", message: "Failed to fetch product posts associated with company with error: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }

            // Check if any products are associated with this company
            let productFetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
            productFetchRequest.predicate = NSPredicate(format: "company_id == %ld", companyId)

            do {
                let products = try context.fetch(productFetchRequest)
                if !products.isEmpty {
                    let alert = UIAlertController(title: "Error", message: "There are products associated with this company id. Please disassociate or delete them before deleting the company.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            } catch let error {
                // Handle any errors that occur during fetch
                let alert = UIAlertController(title: "Error", message: "Failed to fetch products associated with company with error: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }

            // Delete the selected company from Core Data
            context.delete(selectedCompany)
            do {
                try context.save()
                // Remove the selected company from the companies array
                Companies.remove(at: indexPath.row)
                // Delete the row from the table view
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error deleting company: \(error.localizedDescription)")
            }
        }
    }


}
extension CompanyTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Get the search text from the search bar
        if let searchText = searchController.searchBar.text {
            // Call a method to fetch companies with the search text
            fetchCompanies(with: searchText)
        }
    }
}
