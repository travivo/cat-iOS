//
//  CatViewController.swift
//  Cats
//
//  Created by aljon antiola on 10/11/24.
//

import UIKit

class CatViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var catFactsView: UIView!
    @IBOutlet weak var catFactsLabel: UILabel!
    
    private var viewModel = CatViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
        
        // Setup tap gesture to refresh content
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        catFactsView.applyGradientWithTransparency(startColor: UIColor.clear, endColor: UIColor.black.withAlphaComponent(0.8))
    }
    
    private func setupUI() {
        view.backgroundColor = .white
    }
    
    private func setupData() {
        fetchDataAndUpdateUI()
    }
    
    private func fetchDataAndUpdateUI() {
        viewModel.fetchCatData { [weak self] error in
            if let error = error {
                print("Error fetching cat data: \(error)")
                return
            }
            
            self?.updateUI()
        }
    }
    
    private func updateUI() {
        if let urlString = viewModel.getNextImageUrl(), let url = URL(string: urlString) {
            viewModel.loadImage(from: url) { [weak self] image in
                self?.imageView.image = image
                
                // Preload the next image
                self?.viewModel.preloadNextImage()
                
                // Move to the next image for the next tap
                self?.viewModel.advanceToNextImage()
                self?.catFactsView.isHidden = false

                if let fact = self?.viewModel.getNextFact() {
                    self?.catFactsLabel.text = fact
                    self?.catFactsLabel.isHidden = false
                }
            }
        }
    }
    
    @objc private func didTapScreen() {
        if viewModel.shouldFetchNewData() {
            viewModel.clearImageCache()
            fetchDataAndUpdateUI()
        } else {
            updateUI()
        }
    }
}
