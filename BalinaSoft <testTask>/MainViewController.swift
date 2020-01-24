//
//  MainViewController.swift
//  BalinaSoft <testTask>
//
//  Created by Ivan Myrza on 01/11/2019.
//  Copyright © 2019 Ivan Myrza. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let networkManager = NetworkManager()
    var id: Int?
    var pageId = 0
    let activityIndicator = UIActivityIndicatorView()
    var content: [Content]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.delegate = self
        setupActivityIndicator()
        networkManager.fetchData(pageId)
        content = [Content]()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainViewCell
        cell.textLabel?.text = content[indexPath.row].name
        self.id = content[indexPath.row].id
        
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.alertAction()
    }
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func alertAction() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        let cameraButton = UIAlertAction(title: "Camera", style: .default) { _ in
            self.openCamera()
        }
        alert.addAction(cameraButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    
    func openCamera() {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary //.camera for open camera
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[/*.livePhoto for open camera*/.editedImage] as? UIImage {
            networkManager.uploadData(Picture(developerName: "MIM", id: id!, image: image))
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

extension MainViewController {
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == tableView {
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                
                activityIndicator.isHidden = false
                activityIndicator.startAnimating()
                
                if let totalPages = self.networkManager.jsonObject?.totalPages {
                    
                    var totalPagesValue = totalPages
                    
                    if totalPagesValue >= 0 {
                        totalPagesValue -= 1
                        self.pageId += 1
                        networkManager.fetchData(pageId)
                    }
                }
            }
        }
    }
}

extension MainViewController {
    
    func setupActivityIndicator() {
        activityIndicator.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        self.view.addSubview(activityIndicator)
    }
}
extension MainViewController: NetworkManagerDelegate {
    
    func passContent(_ content: [Content]) {
        self.content = content
        self.tableView.reloadData()
    }
}


