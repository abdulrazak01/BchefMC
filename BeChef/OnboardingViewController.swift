//
//  OnboardingViewController.swift
//  BeChef
//
//  Created by Rian Anjasmara on 14/11/20.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var holderView: UIView!
    let scrollview = UIScrollView()
    let pageControl1 = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available (iOS 13.0, *){
            overrideUserInterfaceStyle = .dark
        }
        
        scrollview.delegate = self
      configure()
            }
    
     func viewDidLayoutSubViews(){
        super.viewDidLayoutSubviews()
        configure()
        }
        
    
        
        private func configure(){
            scrollview.showsHorizontalScrollIndicator = false
            scrollview.frame = CGRect(x: 0, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height)
            holderView.addSubview(scrollview)
            
            let titles = ["Ketika lapar datang menyerang", "Pilih jagoan-jagoan terbaikmu", "Lancarkan jurus-jurusnya"]
            let title = ["4 pahlawan ini siap membantumu melawan monster “Lapar”!", "Pilih dan kombinasikan jurus mereka untuk mengalahkan monster “Lapar”!", "Bersama jagoanmu, lancarkan jurusnya, dan kalahkan monster “Lapar”!"]
            
            let pageControl = UIPageControl(frame: CGRect(x: 10, y: holderView.frame.size.height-175, width: holderView.frame.size.width-20, height: 70))
           
           
            for x in 0..<3 {
                let pageView = UIView(frame: CGRect(x: CGFloat(x) * (holderView.frame.size.width), y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
                scrollview.addSubview(pageView)
                
                let label = UILabel(frame: CGRect(x: 10, y: 500, width: pageView.frame.size.width-20, height: 120))
                let label1 = UILabel(frame: CGRect(x: 20, y: 550, width: pageView.frame.size.width-40, height: 120))
                
                let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: pageView.frame.size.width-20, height: pageView.frame.size.height-60-130-15))
    
                let button = UIButton(frame: CGRect(x: 40, y: holderView.frame.size.height-100, width: holderView.frame.size.width-80, height: 50))
                
    
                label.textAlignment = .center
                label.font = UIFont(name: "SF Pro Rounded", size: 20)
                label.font = UIFont.boldSystemFont(ofSize: 20)
                label.textColor = .white
                label.numberOfLines = 0
                pageView.addSubview(label)
                label.text = titles[x]
                
                label1.textAlignment = .center
                label1.font = UIFont(name: "SF Pro Rounded", size: 17)
                label1.textColor = .white
                label1.numberOfLines = 0
                pageView.addSubview(label1)
                label1.text = title[x]
            
                imageView.contentMode = .scaleAspectFit
                imageView.image = UIImage(named: "onboarding\(x)")
                pageView.addSubview(imageView)
                
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .orange
                button.setTitle("Berikutnya", for: .normal)
                button.layer.cornerRadius = 12
                button.tag = x+1
                button.isHidden = true
                
                pageControl.numberOfPages = 3
                if x == 2 {
                    button.setTitle("Mulai", for: .normal)
                    button.isHidden = false
                    pageControl.currentPage = 3
                } else if x == 1 {
                    pageControl.currentPage = 2
                    
                    
                } else {
                    pageControl.currentPage = 1
                    
                }
                
                
                
                
                button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
                
                
               
            
                holderView.addSubview(pageControl)
                pageView.addSubview(button)
                
                
//                button1.setTitleColor(.white, for: .normal)
//                button1.backgroundColor = .none
//                button1.setTitle("Lewati", for: .normal)
//                button1.layer.cornerRadius = 12
//                button1.tag = x+1
//                if x == 2 {
//                    button1.isHidden = true
//                }
//                button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
//                pageView.addSubview(button)
            }
//            holderView.addSubview(pageControl)
            
            
            scrollview.contentSize = CGSize(width: holderView.frame.size.width*3, height: 0)
            scrollview.isPagingEnabled = true
        
            
    }
    
    
    @objc func didTapButton(_ button: UIButton){
        guard button.tag < 3  else {
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let destinationViewController = mainStoryboard.instantiateViewController(withIdentifier: "aaa") as? UINavigationController else {
                print("ga nemu")
                return
            }
            destinationViewController.modalPresentationStyle = .fullScreen
            present(destinationViewController, animated: true, completion: nil)
            
            
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! ViewController
//
//            self.present(newViewController, animated: true, completion: nil)
            
            return
        }
        scrollview.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

