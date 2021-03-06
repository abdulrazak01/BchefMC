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
    var lewatiItem = UIButton()
    var currentStep: Int = 0
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        return pageControl
    }()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available (iOS 13.0, *){
            overrideUserInterfaceStyle = .dark
        }
        
        scrollview.delegate = self
        pageControl.currentPage = 0
      configure()
            }
    
     func viewDidLayoutSubViews(){
        super.viewDidLayoutSubviews()
        configure()
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollview.contentOffset.x / CGFloat(414))
    }
        
    
        
        private func configure(){
            scrollview.showsHorizontalScrollIndicator = false
            scrollview.frame = CGRect(x: 0, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height)
            holderView.addSubview(scrollview)
            
            let titles = ["Ketika lapar datang menyerang", "Pilih jagoan-jagoan terbaikmu", "Lancarkan jurus-jurusnya"]
            let title = ["4 pahlawan ini siap membantumu melawan monster “Lapar”!", "Pilih dan kombinasikan jurus mereka untuk mengalahkan monster “Lapar”!", "Bersama jagoanmu, lancarkan jurusnya, dan kalahkan monster “Lapar”!"]
            
            pageControl.frame = CGRect(x: 10, y: holderView.frame.size.height-180, width: holderView.frame.size.width-20, height: 70)
           
           
            for x in 0..<3 {
                let pageView = UIView(frame: CGRect(x: CGFloat(x) * (holderView.frame.size.width), y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
                scrollview.addSubview(pageView)
                
                let label = UILabel(frame: CGRect(x: 10, y: 450, width: pageView.frame.size.width-20, height: 120))
                
                
                let label1 = UILabel(frame: CGRect(x: 20, y: 490, width: pageView.frame.size.width-40, height: 120))
                
                
                let imageView = UIImageView(frame: CGRect(x: 10, y: -20, width: pageView.frame.size.width-20, height: pageView.frame.size.height-60-130-15))
    
                let button = UIButton(frame: CGRect(x: 40, y: holderView.frame.size.height-100, width: holderView.frame.size.width-80, height: 57))
                
    
                lewatiItem = UIButton(frame: CGRect(x: 10, y: holderView.frame.size.height-250, width: holderView.frame.size.width-20, height: 70))
                let attributedString = NSAttributedString(string: NSLocalizedString("Lewati", comment: ""), attributes:[
                    NSAttributedString.Key.font : UIFont(name: "SFProRounded-Regular", size: 17)!,
                    NSAttributedString.Key.foregroundColor : UIColor.white,
                    NSAttributedString.Key.underlineStyle:1.0
                ])
                lewatiItem.setAttributedTitle(attributedString, for: .normal)
                lewatiItem.backgroundColor = .none
                lewatiItem.setTitle("Lewati", for: .normal)
                lewatiItem.setTitleColor(.white, for: .normal)
                lewatiItem.addTarget(self, action: #selector(pressedRight(_ :)), for: .touchUpInside)
                lewatiItem.layer.masksToBounds = true
                pageView.addSubview(lewatiItem)
                
                
                label.textAlignment = .center
                label.font = UIFont(name: "SFProRounded-Bold", size: 20)
                label.textColor = .white
                label.numberOfLines = 0
                pageView.addSubview(label)
                label.text = titles[x]
                
                label1.textAlignment = .center
                label1.font = UIFont(name: "SFProRounded-Regular", size: 17)
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
                
                pageControl.numberOfPages = title.count
                if x == 2 {
                    button.setTitle("Mulai Kuy!", for: .normal)
                    button.titleLabel?.font = UIFont(name: "SFProRounded-Bold", size: 32)
                    button.isHidden = false
                    lewatiItem.isHidden = true
                }
                    
                pageControl.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
                pageControl.currentPageIndicatorTintColor = .yellow
                
                
                button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
                
            
                holderView.addSubview(pageControl)
                pageView.addSubview(button)
                
            }

            scrollview.contentSize = CGSize(width: holderView.frame.size.width*3, height: 0)
            scrollview.isPagingEnabled = true
            
        
            
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
        currentStep = Int(pageNumber)
        
    }
    
    @objc func pressedRight(_ sender: UIButton) {
        let contentOffset = CGPoint(x: holderView.frame.size.width * CGFloat(2), y: scrollview.contentOffset.y)
        scrollview.setContentOffset(contentOffset, animated: true)
          print("Lewati Press")

    }
    
    @objc func pageControlDidChange(_ sender: UIPageControl){
        let current = sender.currentPage
        scrollview.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(current), y: 0), animated: true)
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
    
         return
        }
        scrollview.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
        
    }

  
}
