//
//  MoviesViewController.swift
//  EverydayApp
//
//  Created by Danijel on 11/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MoviesListViewController: BaseViewController {
    
    @IBOutlet weak var moviesTableView: UITableView!
    
    var presenter: MoviesListScreenContract.Presenter!
    
    var colorsDict = Dictionary<Int32, Any>()
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MoviesListScreenPresenter(view: self)
        presenter.loadPopularMovies()
    }
    
    //MARK: - Navigation title
    override func navigationTitle() -> String {
        return "Movies"
    }
    
}

extension MoviesListViewController: MoviesListScreenContract.View {
    
    func setupTableView() {
        
        self.moviesTableView.register(UINib(nibName: MoviesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MoviesTableViewCell.identifier)
        
        self.moviesTableView.dataSource = self
        self.moviesTableView.delegate = self
        
        self.moviesTableView.reloadData()
    }
    
}
//MARK 
extension MoviesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getPopularMoviesRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowCell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as! MoviesTableViewCell
        let movie = presenter.getMovieWithIndex(index: indexPath.row)
        
        if let posterPath = movie.posterPath {
            
            weak var weakSelf = self
            weak var weakRowCell = rowCell
            
            rowCell.moviePosterImageView.sd_setImage(with: presenter.getPosterURL(path: posterPath), completed: { (image, error, type, url) in
                if image == nil {
                    weakSelf?.setupTexts(rowCell: weakRowCell, movie: movie)
                    return
                }
                
                if self.colorsDict[movie.id] != nil {
                    weakSelf?.setupCellLabelsColor(weakRowCell: weakRowCell, colors: self.colorsDict[movie.id] as? UIImageColors)
                    weakSelf?.setupTexts(rowCell: weakRowCell, movie: movie)
                } else {
                    image?.getColors { colors in
                        weakSelf?.colorsDict.updateValue(colors, forKey: movie.id)
                        
                        weakSelf?.setupCellLabelsColor(weakRowCell: weakRowCell, colors: colors)
                        weakSelf?.setupTexts(rowCell: weakRowCell, movie: movie)
                    }
                }
            })
        } else {
            setupTexts(rowCell: rowCell, movie: movie)
        }
        
        rowCell.selectionStyle = .none
        
        return rowCell
    }
    
    func setupCellLabelsColor(weakRowCell: MoviesTableViewCell?, colors: UIImageColors?) {
        guard let wRowCell = weakRowCell else {
            return
        }
            
        wRowCell.contentView.backgroundColor = colors?.background
        wRowCell.movieOverviewTextView.backgroundColor = colors?.background
        
        wRowCell.movieScoreLabel.textColor = colors?.primary.maxBright()
        
        wRowCell.movieTitleLabel.textColor = colors?.primary
        wRowCell.movieOriginalTitleLabel.textColor = colors?.secondary
        wRowCell.movieOverviewTextView.textColor = colors?.detail
    }
    
    func setupTexts(rowCell: MoviesTableViewCell?, movie: Movie) {
        guard let safeRowCell = rowCell else {
            return
        }
        
        safeRowCell.movieTitleLabel.text = movie.title
        safeRowCell.movieOriginalTitleLabel.text = movie.originalTitle
        safeRowCell.movieOverviewTextView.text = movie.overview
        safeRowCell.movieScoreLabel.text = String(format: "%.1f", movie.voteAverage)
        
        safeRowCell.moviePosterImageView.isHidden = false
        safeRowCell.loadingIndicator.isHidden = true
        safeRowCell.movieScoreLabel.isHidden = false
    }
    
}

extension MoviesListViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MoviesConstants.tableViewCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectFilteredMovie(index: indexPath.row)
    }
    
}
