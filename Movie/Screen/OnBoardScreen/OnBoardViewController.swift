//
//  OnBoardViewController.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import UIKit

class OnBoardViewController: UIViewController {
    @IBOutlet weak var onBoardCollection: UICollectionView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var descriptionLb: UILabel!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextBtn: UIButton!
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == OnBoardSlide.onBoard.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            }else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    var maxPage = OnBoardSlide.onBoard.count - 1
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        navigationController?.isNavigationBarHidden = true
        pageControl.numberOfPages = OnBoardSlide.onBoard.count
        onBoardCollection.delegate = self
        onBoardCollection.dataSource = self
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        onBoardCollection.backgroundColor = .clear
        onBoardCollection.collectionViewLayout = layout
        onBoardCollection.isPagingEnabled = true
        onBoardCollection.showsHorizontalScrollIndicator = true
    }
    private func showCaption(atIndex index: Int) {
        let slide = OnBoardSlide.onBoard[index]
        titleLb.text = slide.title
        descriptionLb.text = slide.description
    }
   
    
    @IBAction func skipBtn(_ sender: Any) {
        OnBoardServices.shared.makeOnBoard()
        let gotoLogin = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ScreenSelectedViewController")
        navigationController?.pushViewController(gotoLogin, animated: true)
    }
    @IBAction func nextPageControl(_ sender: Any) {
        if currentPage == OnBoardSlide.onBoard.count - 1{
            OnBoardServices.shared.makeOnBoard()
            let gotoLogin = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ScreenSelectedViewController")
            navigationController?.pushViewController(gotoLogin, animated: true)
        }else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onBoardCollection.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
            showCaption(atIndex: currentPage)
        }
    }
}

extension OnBoardViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OnBoardSlide.onBoard.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let onBoardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OneBoardCollectionViewCell", for: indexPath) as! OneBoardCollectionViewCell
        let imageName = OnBoardSlide.onBoard[indexPath.item].image
        let image = UIImage(named: imageName) ?? UIImage()
        onBoardCell.configue(image: image)
        return onBoardCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return collectionView.frame.size
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
       func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
           let index = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
           showCaption(atIndex: index)
           pageControl.currentPage = index
       }
    
}
