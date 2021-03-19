//
//  MainScreenViewController.swift
//  Ainstags
//
//  Created by Andrey Gavryutenkov on 7/4/19.
//  Copyright © 2019 Andrey Gavryutenkov. All rights reserved.
//

import UIKit
class MainScreenViewController: BaseViewController, BaseViewProtocol, BaseViewControllerOutputProtocol {
    
    typealias ViewClass = MainScreenView
    typealias OutputClass = MainScreenViewOutput
    
    //MARK: Infinite scroll
    private var isCurrentState: Bool = true
    private var isPreviousState: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rootView.tblResults.register(ImageInfoTableViewCell.self)
        rootView.tblResults.tableFooterView = UIView()
        rootView.tblResults.delegate = self
        rootView.tblResults.dataSource = self
        rootView.showLoading()
    }

}


extension MainScreenViewController: MainScreenViewInput {
    
    func updateUI() {
        rootView.tblResults.reloadData()
        rootView.hideLoading()
    }
}


extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewOutput?.cellsDescriptions.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let description = viewOutput?.cellsDescriptions[indexPath.row] else { return UITableViewCell() }
        
        let cell = tableView.configureCell(with: description, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        viewOutput?.didSelect(indexPath.row)
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isInfiniteScroll () {
            isPreviousState = false
            viewOutput?.loadNextPage()
        }
    }
}


private extension MainScreenViewController {
    private func isInfiniteScroll ()-> Bool {
        isPreviousState = isCurrentState
        
        let isScrolled = rootView.tblResults.contentOffset.y >
            rootView.tblResults.contentSize.height - rootView.tblResults.frame.height
        
        isCurrentState = isScrolled ? true : false
        
        return  isCurrentState && !isPreviousState
    }
}
