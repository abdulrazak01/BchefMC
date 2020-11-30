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
    
    var image1 = UIImage()
    var tittle1 = ""
    var step1 = ""
    var bumbu1 = ""
    var dataJson = [Jobs]()
    var arrayStep = [String]()
    var arrayImg = [String]()
    var totalStep: Int = 0
    var currentStep: Int = 0
    
    //Instanciate with global scope
    var subTitleLabel = UILabel()
    var buttonEnd = UIButton()
    var closeButton = UIButton()
    var leftButton = UIButton()
    var rightButton = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
        self.navigationController?.isNavigationBarHidden = true
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
        
        
        let JsonfromCK = step1.self
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
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 60, width: holderView1.frame.size.width-40, height: 120))
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "SFProRounded-Bold", size: 36)
        //titleLabel.font = UIFont.boldSystemFont(ofSize: 36)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.text = tittle1
        holderView1.addSubview(titleLabel)
        
        //Subtitle Label
        subTitleLabel = UILabel(frame: CGRect(x: 0, y: 100, width: holderView1.frame.size.width-10, height: 120))
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont(name: "SFProRounded-Regular", size: 17)
        subTitleLabel.textColor = UIColor(hexString: "B5A3A3")
        subTitleLabel.numberOfLines = 0
        subTitleLabel.text = "Langkah 1 dari \(dataJson.count)"
        
        totalStep = dataJson.count
        
        //Button End
        buttonEnd = UIButton(frame: CGRect(x: 40, y: holderView1.frame.size.height-100, width: holderView1.frame.size.width-80, height: 57))
        buttonEnd.setTitleColor(.white, for: .normal)
        buttonEnd.setTitle("Selesai", for: .normal)
        buttonEnd.titleLabel?.font = UIFont(name: "SFProRounded-Bold", size: 24)
        buttonEnd.backgroundColor = UIColor(hexString: "FF6B00")
        buttonEnd.layer.cornerRadius = 12
        buttonEnd.addTarget(self, action: #selector(pressedClose(_ :)), for: .touchUpInside)
        buttonEnd.isHidden = true
        holderView1.addSubview(buttonEnd)
        
        
        //CloseButton
        closeButton =  UIButton(frame: CGRect(x: holderView1.frame.size.width * 0.866, y: 70, width: 36, height: 36))
        closeButton.setTitle("􀁡", for: .normal)
        closeButton.setTitleColor(UIColor(red: 1, green: 0.78, blue: 0.07, alpha: 1), for: .normal)
        closeButton.titleLabel?.font = UIFont(name: "SFProRounded-Regular", size: 28)
        closeButton.addTarget(self, action: #selector(pressedClose(_ :)), for: .touchUpInside)
        closeButton.layer.cornerRadius = closeButton.frame.width / 2
        closeButton.layer.masksToBounds = true
        holderView1.addSubview(closeButton)
        
        
        //LeftButton
        leftButton = UIButton(frame: CGRect(x: 16, y: (holderView1.frame.size.height-58)/2, width: 58, height: 58))
        leftButton.backgroundColor = UIColor(red: 0.047, green: 0.067, blue: 0.219, alpha: 0.7)
        leftButton.setTitle("􀄦", for: .normal)
        leftButton.setTitleColor(.white, for: .normal)
        leftButton.titleLabel?.font = UIFont(name: "SFProRounded-Regular", size: 32)
        leftButton.addTarget(self, action: #selector(pressedLeft(_ :)), for: .touchUpInside)
        leftButton.layer.cornerRadius = leftButton.frame.width / 2
        leftButton.isHidden = true
        leftButton.layer.masksToBounds = true
        holderView1.addSubview(leftButton)
        
        //RightButton
        rightButton = UIButton(frame: CGRect(x: holderView1.frame.size.width * 0.795, y: (holderView1.frame.size.height-58)/2, width: 58, height: 58))
        rightButton.backgroundColor = UIColor(red: 0.047, green: 0.067, blue: 0.219, alpha: 0.7)
        rightButton.setTitle("􀄧", for: .normal)
        rightButton.setTitleColor(.white, for: .normal)
        rightButton.titleLabel?.font = UIFont(name: "SFProRounded-Regular", size: 32)
        rightButton.addTarget(self, action: #selector(pressedRight(_ :)), for: .touchUpInside)
        rightButton.layer.cornerRadius = rightButton.frame.width / 2
        rightButton.layer.masksToBounds = true
        holderView1.addSubview(rightButton)

        
        
        
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
            let lblInstruksi = UILabel(frame: CGRect(x: 30, y: pageView.frame.size.height/2 * 1.4, width: pageView.frame.size.width-60, height: 120))
            lblInstruksi.textAlignment = .center
            lblInstruksi.font = UIFont(name: "SFProRounded-Bold", size: 22)
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
        currentStep = Int(pageNumber)
        
        checkCurrentPage()
    }
    
    @objc func pageControlDidChange(_ sender: UIPageControl){
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: holderView1.frame.size.width * CGFloat(current), y: 0), animated: true)
    }
    
    @objc func pressedClose(_ sender: UIButton) {
        print(step1)
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeStepVC") as? RecipeStepVC
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.step = step1
        vc?.tittle = tittle1
        vc?.bumbu = bumbu1
        vc?.image = image1
        print("Press Close")
    }
    
    @objc func pressedLeft(_ sender: UIButton) {
        currentStep -= 1
        let contentOffset = CGPoint(x: holderView1.frame.size.width * CGFloat(currentStep), y: scrollView.contentOffset.y)
        scrollView.setContentOffset(contentOffset, animated: true)
        print(currentStep)
        print("Press Left")
        checkCurrentPage()
    }
    
    @objc func pressedRight(_ sender: UIButton) {
        // Set CGPoint based on right scroll
        // X = - (currentStep + 1) * scrollViewWidth
        currentStep += 1
        let contentOffset = CGPoint(x: holderView1.frame.size.width * CGFloat(currentStep), y: scrollView.contentOffset.y)
        print(currentStep)
        scrollView.setContentOffset(contentOffset, animated: true)
        print("Press Right")
        print(currentStep+1)
        checkCurrentPage()
    }
    
    func checkCurrentPage (){
        
        subTitleLabel.text = "Langkah \(currentStep+1) dari \(totalStep)"
        
        
        if  currentStep+1 == 1 {
            leftButton.isHidden = true
        } else {
            leftButton.isHidden = false
        }
        
        if  currentStep+1 == totalStep {
            rightButton.isHidden = true
            buttonEnd.isHidden = false
        } else {
            rightButton.isHidden = false
            buttonEnd.isHidden = true
        }
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

