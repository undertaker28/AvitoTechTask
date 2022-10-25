//
//  ViewController.swift
//  AvitoTechTask
//
//  Created by Pavel on 21.10.22.
//

import UIKit
import Reachability

class ViewController: UIViewController {
    
    public var data: CompanyModel?
    public var employeesFiltered: [Employee]?
    private let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "wifi"), style: .plain, target: ViewController.self, action: nil)
    private var networkManager: NetworkOutput
    private var rightBarButtonItem: SystemSymbol = .wifi {
        didSet {
            DispatchQueue.main.async {
                self.rightBarButton.image = UIImage(systemName: self.rightBarButtonItem.rawValue)
                self.navigationItem.rightBarButtonItem = self.rightBarButton
            }
        }
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let reachability = try? Reachability()
    
    init(networkManager: NetworkOutput) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
        setupNavBarAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        checkReachable()
        startObserve()
    }
    
    func startObserve() {
        try? reachability?.startNotifier()
    }
    
    func checkReachable() {
        reachability?.whenReachable = { [weak self] reachability in
            self?.setup()
        }
        
        reachability?.whenUnreachable = { [weak self] _ in
            self?.rightBarButtonItem = .wifiSlash
            self?.showAlert()
        }
    }
    
    func setup() {
        self.rightBarButtonItem = .wifi
        self.configCollectionView()
        self.constraintLayout()
        self.networkManager.fetchData { avito in
            self.data = avito
            self.employeesFiltered = self.data?.company.employees
            self.employeesFiltered?.sort(by: {$0.name < $1.name})
            self.collectionView.reloadData()
        }
    }
    
    func setupView() {
        view.backgroundColor = UIColor.smokyWhite
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func setupNavBarAppearance() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.blue]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.blue]
    }
    
    func configCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.smokyWhite
        collectionView.register(EmployeeCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: EmployeeCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func constraintLayout() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Connection problems!", message: "You don't have internet connection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
