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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        scrollView.delegate = self
        pageController.currentPage = 0
        readLangkah()
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

        let label1 = UILabel(frame: CGRect(x: 20, y: 550, width: holderView1.frame.size.width-40, height: 120))
        label1.text = tittle
        
        for index in 0..<dataJson.count{

            let pageView = UIView(frame: CGRect(x: CGFloat(index) * (holderView1.frame.size.width), y: 0, width: holderView1.frame.size.width, height: holderView1.frame.size.height))
            scrollView.addSubview(pageView)
            
            
            
            //ImageView
            let imgInstruksi = UIImageView(frame: CGRect(x: 10, y: 0, width: pageView.frame.size.width-20, height: pageView.frame.size.height-60-130-15))
            let urlGambar = URL(string: arrayImg[index])
            imgInstruksi.contentMode = .scaleAspectFill
            imgInstruksi.load(url: urlGambar!)
            
            //label
            let lblInstruksi = UILabel(frame: CGRect(x: 10, y: 300, width: pageView.frame.size.width-20, height: 120))
            lblInstruksi.textAlignment = .center
            lblInstruksi.font = UIFont(name: "SF Pro Rounded", size: 20)
            lblInstruksi.textColor = .black
            lblInstruksi.numberOfLines = 0
            lblInstruksi.text = arrayStep[index]
            
            //add to scrollview
            pageView.addSubview(imgInstruksi)
            pageView.addSubview(lblInstruksi)
            
            
            
            pageController.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
            pageController.numberOfPages = dataJson.count
            holderView1.addSubview(pageController)
            pageController.backgroundColor = .black
            pageController.currentPageIndicatorTintColor = .white
            
        }
        
        
        scrollView.contentSize = CGSize(width: holderView1.frame.size.width*CGFloat(dataJson.count), height: 0)
        scrollView.isPagingEnabled = true
        

     }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageController.currentPage = Int(pageNumber)
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

/*class makeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    
    var langkahsteps: Jobs! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let langkahstep = langkahsteps {
            title.text = langkahstep.instruksi
        }
    }
    
} */
