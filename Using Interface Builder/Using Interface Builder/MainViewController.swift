//
//  MainViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/26/23.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ManageProductTypesButtonTapped(_ sender: UIButton) {
        let vc = ManageProductTypesViewController(nibName: "ManageProductTypesView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func ManageCompaniesButtonTapped(_ sender: UIButton) {
        let vc = ManageCompaniesViewController(nibName: "ManageCompaniesView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func manageProductsButtonTapped(_ sender: UIButton) {
        let vc = ManageProductsViewController(nibName: "ManageProductsView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func ManageProductPostButtonTapped(_ sender: UIButton) {
        let vc = ManageProductPostsViewController(nibName: "ManageProductPostsView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func ManageOrdersButtonTapped(_ sender: UIButton) {
        let vc = ManageOrdersViewController(nibName: "ManageOrdersView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func ManageSearchButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
