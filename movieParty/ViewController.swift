//
//  ViewController.swift
//  movieParty
//
//  Created by Edmund Holderbaum on 3/10/17.
//  Copyright © 2017 Dawn Trigger Entertainment. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var movie: Movie? = nil
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        displayInfo()
    }
    
    func displayInfo() {
        self.titleLabel.text = movie?.title
        self.plotLabel.text = movie?.plot
        self.genreLabel.text = movie?.genre
        self.yearLabel.text = movie?.year
    }
}

