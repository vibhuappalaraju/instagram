//
//  HomeViewController.swift
//  instagram
//
//  Created by Vibhu Appalaraju on 10/2/18.
//  Copyright © 2018 Vibhu Appalaraju. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: ViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [Post] = []
    var refreshControl: UIRefreshControl!
    @IBAction func Onlogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self;
        tableView.dataSource = self;
        getPostToPhotos()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 50
        tableView.reloadData()
    }
    
    @objc func didPullToRefresh(_ refreshControl:UIRefreshControl) {
        getPostToPhotos()
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func getPostToPhotos(){
        // construct query
        let query = Post.query()
        query?.includeKey("media")
       //query.whereKey("likesCount", greaterThan: 100)
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.tableView.reloadData()
                 self.refreshControl.endRefreshing()
                
            }
            else{
                print(error?.localizedDescription)
                self.refreshControl.endRefreshing()
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = self.posts[indexPath.row]
        let cellImage = post.media as PFFile
        cell.likesLabel.text = String(post.likesCount)
        cellImage.getDataInBackground{ (imageData: Data?, error: Error?) in
            if (error == nil) {
                if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    cell.instaImage.image = image
                }
            }
        }
        cell.instaCaptionLabel.text = String(post.caption)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return posts.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let post = self.posts[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.post = post
            
        }
        
    }
    

  

}
