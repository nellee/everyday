//
//  MoviesViewController.swift
//  EverydayApp
//
//  Created by Danijel on 13/06/2017.
//  Copyright © 2017 NELI_IT. All rights reserved.
//

import Foundation
import UIKit
import youtube_ios_player_helper
import SDWebImage

class MovieViewController: BaseViewController {
    
    @IBOutlet weak var ytPlayerView: YTPlayerView!
    
    @IBOutlet weak var movieDetailsViewContainer: UIView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieOriginalTitleLabel: UILabel!
    @IBOutlet weak var movieGenresLabel: UILabel!
    @IBOutlet weak var movieReleaseDateLabel: UILabel!
    
    @IBOutlet weak var movieOverviewTextView: UITextView!
    @IBOutlet weak var movieIMDBButton: UIButton!
    
    @IBOutlet weak var movieVoteLabel: UILabel!
    
    var presenter: MovieScreenContract.Presenter!
    
    var movieID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MovieScreenPresenter(view: self)
        presenter.fetchMovieTrailerData(movieID: self.movieID)
        presenter.fetchMovieData(movieID: self.movieID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        ytPlayerView.stopVideo()
    }
    
    @IBAction func movieIMDBButtonClicked(_ sender: Any) {
        
    }
}

extension MovieViewController: MovieScreenContract.View {
    
    func setupYTPlayer() {
        ytPlayerView.delegate = self
    }
    
    func setupMovieView() {
        
    }
    
    func movieTrailerDataLoaded(key: String?) {
        guard let safeKey = key else {
            return
        }
        let pv: [String: Int] = [
            "playsinline" : 1,
            "showinfo" : 0,
            "controls" : 0,
            "rel" : 0
        ]
        ytPlayerView.load(withVideoId: safeKey, playerVars: pv)
    }
    
    func movieLoaded(movieData: Movie) {
        if let posterPath = movieData.posterPath {
            weak var weakSelf = self
            moviePosterImageView.sd_setImage(with: presenter.getPosterURL(path: posterPath), completed: { (image, error, type, url) in
                image?.getColors { colors in
                    guard let safeWeakSelf = weakSelf else { return }
                    safeWeakSelf.setupTextColors(colors: colors)
                    safeWeakSelf.setupTexts(movie: movieData)
                    safeWeakSelf.moviePosterImageView.isHidden = false
                    safeWeakSelf.movieIMDBButton.isHidden = false
                }
            })
        }
    }
    
    func setupTexts(movie: Movie) {
        self.movieTitleLabel.text = movie.title
        self.movieOriginalTitleLabel.text = movie.originalTitle
        
        for genre in movie.genres! {
            self.movieGenresLabel.text = self.movieGenresLabel.text! + " " + genre.name!
        }
        
        self.movieReleaseDateLabel.text = movie.releaseDate
        self.movieOverviewTextView.text = movie.overview
        
        self.movieVoteLabel.text = String(format: "Score: %.1f", movie.voteAverage)
        self.movieIMDBButton.setTitle(String(format: "www.imdb.com/title/%@", movie.imdbID!), for: UIControlState.normal)
    }
    
    func setupTextColors(colors: UIImageColors) {
        self.movieDetailsViewContainer.backgroundColor = colors.background
        self.movieOverviewTextView.backgroundColor = colors.background
        
        self.movieTitleLabel.textColor = colors.primary
        self.movieOverviewTextView.textColor = colors.secondary
        self.movieGenresLabel.textColor = colors.detail
        self.movieReleaseDateLabel.textColor = colors.detail
        self.movieOverviewTextView.textColor = colors.detail
        
        self.movieVoteLabel.textColor = colors.primary.maxBright()
    }
    
}

extension MovieViewController: YTPlayerViewDelegate {
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.ytPlayerView.playVideo()
    }
    
}

