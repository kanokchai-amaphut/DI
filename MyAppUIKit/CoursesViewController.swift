//
//  CoursesViewController.swift
//  MyAppUIKit
//
//  Created by Kanokchai Amaphut on 10/5/2567 BE.
//

import UIKit

public protocol DataFetchable {
    func fetchCourseName(completion: @escaping ([String]) -> Void)
}

struct Course {
    let name: String
}

 public class CoursesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     
     let dataFetchable: DataFetchable
     
     private let tableView: UITableView = {
         let table = UITableView()
         table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
         return table
     }()
     
     public init(dataFetchable: DataFetchable) {
         self.dataFetchable = dataFetchable
         super.init(nibName: nil, bundle: nil)
     }
     
     public required init?(coder: NSCoder) {
         fatalError()
     }
     
     var courses: [Course] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .systemBackground
        dataFetchable.fetchCourseName { name in
            self.courses = name.map({ Course(name: $0)})
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
     
     public override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
         tableView.frame = view.bounds
     }
     
     public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return courses.count
     }
     
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         cell.textLabel?.text = courses[indexPath.row].name
         return cell
     }
}
