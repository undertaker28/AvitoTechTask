//
//  ViewController.swift
//  AvitoTechTask
//
//  Created by Pavel on 21.10.22.
//

import UIKit

class ViewController: UIViewController {

    var networkManager: NetworkService
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    init(networkManager: NetworkService) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0/255, green: 170/255, blue: 255/255, alpha: 1)]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(red: 0/255, green: 170/255, blue: 255/255, alpha: 1)]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always

        configCollectionView()
        constraintLayout()
        networkManager.fetchData { avito in
            self.collectionView.reloadData()
        }
        checkInternetConnection()
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

    func checkInternetConnection() {
        networkManager.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
                let alertController = UIAlertController(title: "Отсутствует интернет соединение", message: "Продолжить без подключения", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ОК", style: .default)
                alertController.addAction(okAction)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width - 32
        return CGSize(width: width, height: 200)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networkManager.companyModel?.company.employees.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EmployeeCollectionViewCell.self), for: indexPath) as! EmployeeCollectionViewCell
        var dataSource = networkManager.companyModel!.company.employees
        dataSource.sort(by: {$0.name < $1.name})
        let dataSourceAtIndexPath = dataSource[indexPath.row]
        
        cell.nameLabel.text = "Name: \(dataSourceAtIndexPath.name)"
        cell.phoneNumberLabel.text = "Phone number: \(dataSourceAtIndexPath.phoneNumber)"
        cell.skillsLabel.text = "Skills: \(dataSourceAtIndexPath.skills.joined(separator: ", "))"
        
        title = networkManager.companyModel!.company.name
        return cell
    }
}
