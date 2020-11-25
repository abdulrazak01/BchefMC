//
//  DetailReceiptVC.swift
//  BeChef
//
//  Created by abdulrazak on 07/11/20.
//

import UIKit
import Foundation



class DetailReceiptVC: UIViewController,UIScrollViewDelegate{
   
    

    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var detailimg: UIImageView!

    @IBOutlet weak var lblbumbu: UILabel!
    @IBOutlet weak var lblstep: UILabel!
    
    @IBOutlet weak var lblTitleSea: UILabel!
    @IBOutlet weak var lblTitleStep: UILabel!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblInstruction: UILabel!
    
   
    
    //var image = UIImage()
    //var tittle = ""
    //var bumbu = ""
    var step = ""
    var dataJson = [Jobs]()
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        
       /* lblTitleSea.text = "Seasoning"
        lblTitleStep.text = "Instruction"
        
        lbltitle.text = tittle
        lblbumbu.text = bumbu
        lblstep.text = step
        detailimg.image = image */
        readLangkah()
    
      //  lblbumbu.isEditable = false
       // lblstep.isEditable = false
        // Do any additional setup after loading the view.
    }
    
    func readLangkah (){
        let JsonfromCK = step.self
        let JsonString = JsonfromCK.data(using: .utf8)!
        let decoder = JSONDecoder()
        let Json = try! decoder.decode(langkah.self, from: JsonString)
        self.dataJson = Json.jobs ?? []
        
        
        
        for index in 0..<dataJson.count{
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            print(dataJson[index].gambar!)
            let urlGambar = URL(string: dataJson[index].gambar!)
            let imgView = UIImageView(frame: frame)
            imgView.load(url: urlGambar! )
            let datainstruksi = dataJson[index].instruksi!
            lblInstruction.text = datainstruksi
            self.scrollView.addSubview(imgView)
            
            
            
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(dataJson.count)),height: scrollView.frame.size.height)
        scrollView.delegate = self
        

     }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageController.currentPage = Int(pageNumber)
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
