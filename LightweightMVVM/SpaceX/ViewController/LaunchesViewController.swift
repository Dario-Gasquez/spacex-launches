//
//  ShipsListViewController.swift
//  Buccaneers
//
//  Created by Dario on 3/14/19.
//  Copyright © 2019 Dario Gasquez. All rights reserved.
//

import UIKit

class LaunchesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = NSLocalizedString("Launches", comment: "launches screen title")
        addRefreshControl()
        fetchLaunches()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? LaunchCollectionViewCell else { return }
        
        switch segue.identifier! {
        case Storyboard.showLaunchDetailsSegueIdentifier:
            guard let launchDetailsVC = segue.destination as? LaunchDetailsViewController else { return }
            launchDetailsVC.launchViewModel = cell.launchViewModel
        default:
            break
        }
    }
    
    
    // MARK: - Private Section -
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var launchesView: UICollectionView!
    
    private struct Storyboard {
        static let showLaunchDetailsSegueIdentifier = "ShowLaunchDetails"
    }
    
    private var launches: [LaunchViewModel]? {
        didSet { launchesView.reloadData() }
    }
    
    private var launchesService = LaunchesService()
    
    private func fetchLaunches() {
        launchesService.fetchLaunches { (result) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                switch result {
                case .failure:
                    self.showErrorMessage()
                case .success(let launchesViewModels):
                    self.launchesView.refreshControl?.endRefreshing()
                    self.launches = launchesViewModels
                }
            }
        }
    }
    
    
    private func showErrorMessage() {
        let title = NSLocalizedString("Error fetching launches", comment: "Error alert view: title")
        let message = NSLocalizedString("We could not fetch launches information. Please check your internet connection", comment: "Error alert view: message")
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionText = NSLocalizedString("Ok", comment: "Error alert view: action button text")
        let okAction = UIAlertAction(title: actionText, style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true) {
            self.launchesView.refreshControl?.endRefreshing()
        }
    }
    
    
    private func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        let title = NSLocalizedString("Pull to refresh", comment: "pull to refresh text")
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body),
            .foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        ]
        let attributedTitle = NSAttributedString(string: title, attributes: textAttributes)
        
        
        refreshControl.attributedTitle = attributedTitle
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        launchesView.refreshControl = refreshControl
    }
    
    
    @objc private func refresh() {
        fetchLaunches()
    }
}


//NOTE: It might be a good idea to move the data source functionality to a different class
extension LaunchesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.launches?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LaunchCollectionViewCell", for: indexPath) as? LaunchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.launchViewModel = launches?[indexPath.row]
        return cell
    }
}


extension LaunchesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        launchesService.fetchMissionPatchImage(at: indexPath.row) { (launchViewModel) in
            DispatchQueue.main.async {
                guard let launchVM = launchViewModel  else { return }
                let launchViewCell = cell as? LaunchCollectionViewCell
                
                launchViewCell?.launchViewModel = launchVM
            }
        }
    }
}


extension LaunchesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.2, height:  collectionView.frame.height / 3.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}
