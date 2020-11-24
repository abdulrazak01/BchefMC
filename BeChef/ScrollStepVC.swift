//
//  ScrollStepVC.swift
//  BeChef
//
//  Created by Rian Anjasmara on 23/11/20.
//

import UIKit

class ScrollStepVC: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //pageControl.numberOfPages = step.count
        //setupScreens()
        //scrollView.delegate = self
        
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }

}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func setupScreens() {
//        for index in 0..<movies.count {
//            // 1.
//            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
//            frame.size = scrollView.frame.size
//
//            // 2.
//            let imgView = UIImageView(frame: frame)
//            imgView.image = UIImage(named: movies[index])
//
//            self.scrollView.addSubview(imgView)
//        }
//
//        // 3.
//        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(movies.count)), height: scrollView.frame.size.height)
//        scrollView.delegate = self
//    }
    
   
