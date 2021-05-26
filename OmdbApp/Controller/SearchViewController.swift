//
//  SearchViewController.swift
//  OmdbApp
//
//  Created by cedcoss on 25/05/21.
//

import UIKit
import SnapKit
import DZNEmptyDataSet

class SearchViewController: UIViewController {
    
    var searchTextLatest      = String()
    var movieListingViewModel : MovieListingViewModel?
    
    //MARK:- Lazy properties
    lazy var searchBar           : UISearchBar = {
        let searchBar            = UISearchBar()
        searchBar.delegate       = self
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder    = "Search here.."
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.clearButtonMode = .never
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView                                        = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints  = false
        tableView.delegate                                   = self
        tableView.dataSource                                 = self
        let nib = UINib(nibName: MovieTVCell.className, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MovieTVCell.className)
        tableView.separatorStyle                             = .none
        tableView.emptyDataSetSource                         = self
        tableView.emptyDataSetDelegate                       = self
        tableView.tableFooterView   = UIView(frame: .zero)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        propertiesAndViewStyling()
        configureUI()
    }
    
    func propertiesAndViewStyling(){
        navigationController?.navigationBar.barTintColor = AppSetUp.themeColor
        self.title                  = "OMDb Movie Search"
        self.view.backgroundColor   = dynamicColor.secondarySystemBackground
        self.edgesForExtendedLayout = []
        self.movieListingViewModel  = MovieListingViewModel(controller: self)
    }
    
    func configureUI(){
        self.view.addSubview(searchBar)
        searchBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5).isActive    = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive         = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive       = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive                       = true
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}


//  MARK: - SearchBar Delegate
//
extension SearchViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        guard let text = searchBar.searchTextField.text else {return}
        searchTextLatest = text
        if !text.isEmpty && text.count >= 3{
            updateSerch()
        }
    }

    @objc func updateSerch(){
        self.movieListingViewModel?.makeNetworkCallForGettingMovies(searchString: searchTextLatest)
    }
}

//  MARK: - TableView Setup
//
extension SearchViewController: UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListingViewModel?.movieListing.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTVCell.className, for: indexPath) as? MovieTVCell
        cell?.configure(with: movieListingViewModel?.movieListing[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

extension SearchViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform  = rotationTransform
        cell.alpha            = 0
        
        UIView.animate(withDuration: 0.45){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
}

//  Can be customized acc to view wanted
extension SearchViewController: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{

    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image         = UIImage(named: "empty")
        image.contentMode   = .scaleAspectFit
        image.clipsToBounds = true

        view.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.width.equalTo(150)
        }
        return view
    }

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return movieListingViewModel?.movieListing.count == 0
    }
}
