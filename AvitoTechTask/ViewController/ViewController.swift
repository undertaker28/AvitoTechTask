//
//  ViewController.swift
//  AvitoTechTask
//
//  Created by Pavel on 21.10.22.
//

import UIKit
import Reachability

class ViewController: UIViewController {

    var networkManager: NetworkService
    var rightBarButtonItem: SystemSymbol = .wifi {
        didSet {
            DispatchQueue.main.async {
                let rightBarButton = UIBarButtonItem(
                    image: UIImage(systemName: self.rightBarButtonItem.rawValue),
                    style: .plain,
                    target: ViewController.self,
                    action: nil)
                self.navigationItem.rightBarButtonItem = rightBarButton
            }
        }
    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let reachability = try! Reachability()

    init(networkManager: NetworkService) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 76/255, green: 167/255, blue: 248/255, alpha: 1)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 76/255, green: 167/255, blue: 248/255, alpha: 1)]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        checkReachable()
        startObserve()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
    }
    
    func startObserve() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func checkReachable() {
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Connection via wifi")
                self.setup()
            } else {
                print("Connection via celluar")
                self.setup()
            }
        }
        
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.rightBarButtonItem = .wifiSlash
            self.showAlert()
        }
    }
    
    func setup() {
        self.rightBarButtonItem = .wifi
        self.configCollectionView()
        self.constraintLayout()
        self.networkManager.fetchData { avito in
            self.collectionView.reloadData()
        }
    }

    func configCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
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
