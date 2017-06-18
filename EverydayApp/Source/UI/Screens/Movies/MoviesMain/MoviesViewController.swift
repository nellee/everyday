//
//  MoviesViewController.swift
//  EverydayApp
//
//  Created by Danijel on 12/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit

class MoviesSearchTableViewCell: UITableViewCell {
    
    static let indentifier = "moviesSearchTabelViewCell"
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
}

class MoviesViewController: BaseViewController {
    
    @IBOutlet weak var moviesSearchBar: UISearchBar!
    @IBOutlet weak var searchBarTableView: UITableView!
    
    @IBOutlet weak var searchBarTableViewHaightConstraint: NSLayoutConstraint!
    
    var presenter: MoviesScreenContract.Presenter!
    
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MoviesScreenPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.clearFilteredData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        moviesSearchBar.resignFirstResponder()
    }
    
    @IBAction func popularButtonClicked(_ sender: Any) {
        presenter.showPopularMoviesInMoviesListController()
    }
    
}

extension MoviesViewController: MoviesScreenContract.View {
    
    func setupSearchBar() {
        moviesSearchBar.delegate = self
    }
    
    func setupSearchBarTableView() {
        searchBarTableView.dataSource = self
        searchBarTableView.delegate = self
    }
    
    func filteredDataLoaded() {
        self.searchBarTableView.reloadData()
    }
    
}

//MARK: - UISearchBar delegate
extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        changeSearchBarState(isSearchBarActive: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        changeSearchBarState(isSearchBarActive: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        changeSearchBarState(isSearchBarActive: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        changeSearchBarState(isSearchBarActive: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            changeSearchBarState(isSearchBarActive: false)
            return
        }
        changeSearchBarState(isSearchBarActive: true)
        self.presenter.filterDataWithSearchText(searchText: searchText)
    }
    
    func changeSearchBarState(isSearchBarActive: Bool) {
        searchActive = isSearchBarActive
        UIView.animate(withDuration: 0.7) {
            self.searchBarTableViewHaightConstraint.constant = self.searchActive ? 400 : 0
            self.view.layoutIfNeeded()
        }
    }
}

//Mark: - UITableView Delegate and DataSource
extension MoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getFilteredDataCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesSearchTableViewCell.indentifier, for: indexPath) as? MoviesSearchTableViewCell
        
        let movie = self.presenter.getFilteredMovie(index: indexPath.row)
        cell?.movieTitleLabel.text = movie.originalTitle
        
        return cell!
    }

}

extension MoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectFilteredMovie(index: indexPath.row)
    }
    
}
