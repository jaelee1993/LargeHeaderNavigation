//
//  ViewController.swift
//  LargerHeader
//
//  Created by Jae Lee on 11/13/18.
//  Copyright © 2018 Jae Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var tableView:UITableView!
    var Headerview : UIView!
    var NewHeaderLayer : CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navSetup()
        self.tableViewSetup()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    private let Headerheight : CGFloat = 420
    
    func tableViewSetup() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.white
        
        //Header View setup
        self.Headerview = self.tableView.tableHeaderView
        self.tableView.tableHeaderView = nil
        self.tableView.addSubview(self.Headerview)
        
        self.NewHeaderLayer = CAShapeLayer()
        self.NewHeaderLayer.fillColor = UIColor.black.cgColor
        self.Headerview.layer.mask = NewHeaderLayer //masking HeaderView with NewHeaderLayer
        
        //inset & offset
        self.tableView.contentInset = UIEdgeInsets(top: self.Headerheight, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -self.Headerheight)
        
        self.setupNewView()
        
    }
    
    func navSetup() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func setupNewView() {
        var getheaderframe = CGRect(x: 0, y: -self.Headerheight, width: self.view.frame.width, height: self.Headerheight)
        if self.tableView.contentOffset.y < self.Headerheight
        {
            getheaderframe.origin.y = self.tableView.contentOffset.y
            getheaderframe.size.height = -self.tableView.contentOffset.y
        }
        self.Headerview.frame = getheaderframe
        let cutdirection = UIBezierPath()
        cutdirection.move(to: CGPoint(x: 0, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: 0))
        cutdirection.addLine(to: CGPoint(x: getheaderframe.width, y: getheaderframe.height))
        cutdirection.addLine(to: CGPoint(x: 0, y: getheaderframe.height))
        NewHeaderLayer.path = cutdirection.cgPath
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tableView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.setupNewView()
        
        var offset = scrollView.contentOffset.y / 150
        if offset > -0.5
        {
            UIView.animate(withDuration: 0.2, animations: {
                offset = 1
                let color = UIColor.init(red: 1, green: 1, blue: 1, alpha: offset)
                let navigationcolor = UIColor.blue
                
                self.navigationController?.navigationBar.tintColor = navigationcolor
                self.navigationController?.navigationBar.backgroundColor = color
                UIApplication.shared.statusBarView?.backgroundColor = color
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: navigationcolor]
                self.navigationController?.navigationBar.barStyle = .default
                self.title = "Black Hole"
            })
        }
        else
        {
            UIView.animate(withDuration: 0.2, animations: {
                let color = UIColor.init(red: 1, green: 1, blue: 1, alpha: offset)
                self.navigationController?.navigationBar.tintColor = UIColor.white
                self.navigationController?.navigationBar.backgroundColor = color
                UIApplication.shared.statusBarView?.backgroundColor = color
                self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
                self.navigationController?.navigationBar.barStyle = .black
                self.title = ""
            })
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let otherCell = tableView.dequeueReusableCell(withIdentifier: "otherCell") as! SomeCell
        otherCell.configure("black hole is here, black hole is here,  black hole is here, black hole is here, black hole is here, black hole is here, black hole is here")
        return otherCell
    }

}





class SomeCell: UITableViewCell {
    @IBOutlet var someLabel:UILabel!
    
    func configure(_ someString:String) {
        self.someLabel.text = someString
    }
}



/**
 To change color of status bar
 */
public extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
