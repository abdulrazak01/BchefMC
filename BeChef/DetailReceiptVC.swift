//
//  DetailReceiptVC.swift
//  BeChef
//
//  Created by abdulrazak on 07/11/20.
//

import UIKit
import Foundation



class DetailReceiptVC: UIViewController, UIScrollViewDelegate{
   
    @IBOutlet weak var holderView1: UIView!
    let scrollView = UIScrollView()
    
    private let pageController: UIPageControl = {
        let pageController = UIPageControl()
        return pageController
    }()
    
    var tittle = ""
    var step = ""
    var dataJson = [Jobs]()
    var arrayStep = [String]()
    var arrayImg = [String]()
    var totalStep: Int = 0
    
    //Instanciate with global scope
    var subTitleLabel = UILabel()
    var buttonEnd = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        scrollView.delegate = self
        pageController.currentPage = 0
        readLangkah()
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        readLangkah()
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        pageController.currentPage = Int(scrollView.contentOffset.x / CGFloat(414))
    }
    
    private func readLangkah (){
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.frame = CGRect(x: 0, y: 0, width: holderView1.frame.size.width, height: holderView1.frame.size.height)
        holderView1.addSubview(scrollView)
        
        
        let JsonfromCK = step.self
        let JsonString = JsonfromCK.data(using: .utf8)!
        let decoder = JSONDecoder()
        let Json = try! decoder.decode(langkah.self, from: JsonString)
        self.dataJson = Json.jobs ?? []
        
        for i in 0..<dataJson.count {
            let img = dataJson[i].gambar!
            let instruksi = dataJson[i].instruksi!
            arrayImg.append(img)
            arrayStep.append(instruksi)
            
        }
        
        pageController.frame = CGRect(x: 10, y: holderView1.frame.size.height-175, width: holderView1.frame.size.width-20, height: 70)
        
        //title Label
        let titleLabel = UILabel(frame: CGRect(x: 20, y: -40, width: holderView1.frame.size.width-40, height: 120))
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "SFProRounded-Bold", size: 36)
        //titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.text = tittle
        holderView1.addSubview(titleLabel)
        
        //Subtitle Label
        subTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: holderView1.frame.size.width-10, height: 120))
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont(name: "SFProRounded-Regular", size: 17)
        subTitleLabel.textColor = UIColor(hexString: "B5A3A3")
        subTitleLabel.numberOfLines = 0
        subTitleLabel.text = "Langkah 1 dari \(dataJson.count)"
        
        totalStep = dataJson.count
        
        //Button End
        buttonEnd = UIButton(frame: CGRect(x: 40, y: holderView1.frame.size.height-100, width: holderView1.frame.size.width-80, height: 50))
        
        
        
        for index in 0..<dataJson.count{
            
            
            let pageView = UIView(frame: CGRect(x: CGFloat(index) * (holderView1.frame.size.width), y: 0, width: holderView1.frame.size.width, height: holderView1.frame.size.height))
            scrollView.addSubview(pageView)
            
            let pageFrame = CGRect(x: 0, y: 0, width: pageView.frame.size.width, height: pageView.frame.size.height)
            
            
            //ImageView
            let imgInstruksi = UIImageView(frame: pageFrame)
            let urlGambar = URL(string: arrayImg[index])
            imgInstruksi.clipsToBounds = true
            imgInstruksi.contentMode = .scaleAspectFit
            imgInstruksi.load(url: urlGambar!)
            
            //label
            let lblInstruksi = UILabel(frame: CGRect(x: 10, y: 500, width: pageView.frame.size.width-20, height: 120))
            lblInstruksi.textAlignment = .center
            lblInstruksi.font = UIFont(name: "SF-Pro-Rounded-Regular", size: 20)
            lblInstruksi.textColor = .white
            lblInstruksi.numberOfLines = 0
            lblInstruksi.text = arrayStep[index]
            
            //FilterBlue
            let imgFilter = UIImageView(frame: pageFrame)
            //imgFilter.contentMode = .scaleAspectFit
            imgFilter.clipsToBounds = true
            imgFilter.image = UIImage(named: "filterBlue-1")

            
            //add to scrollview
            pageView.addSubview(imgInstruksi)
            pageView.addSubview(imgFilter)
            pageView.addSubview(lblInstruksi)
            
            //addButton
           
//            button.setTitleColor(.white, for: .normal)
//            button.backgroundColor = .orange
//            button.layer.cornerRadius = 12
//            button.tag = index+1
//            button.isHidden = true
//
//            if index == 2 {
//                button.setTitle("Mulai", for: .normal)
//                button.isHidden = false
//            }
            
            
            
            pageController.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
            pageController.numberOfPages = dataJson.count
            //holderView1.addSubview(pageController)
            //pageController.backgroundColor = .black
            //pageController.currentPageIndicatorTintColor = .white

            holderView1.addSubview(subTitleLabel)
        }
        
       
        scrollView.contentSize = CGSize(width: holderView1.frame.size.width*CGFloat(dataJson.count), height: 0)
        scrollView.isPagingEnabled = true
     }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageController.currentPage = Int(pageNumber)
        print(pageNumber)
        subTitleLabel.text = "Langkah \(Int(pageNumber)+1) dari \(totalStep)"
        

        
    }
    
    @objc func pageControlDidChange(_ sender: UIPageControl){
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: holderView1.frame.size.width * CGFloat(current), y: 0), animated: true)
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

