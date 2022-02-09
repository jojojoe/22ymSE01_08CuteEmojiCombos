//
//  CEcymStoreVC.swift
//  CECyCuEmojiComb
//
//  Created by Joe on 2022/1/27.
//

import UIKit
import NoticeObserveKit
import ZKProgressHUD

class DIyStoreVC: UIViewController {
    private var pool = Notice.ObserverPool()
    let topCoinLabel = UILabel()
    var collection: UICollectionView!
    let backBtn = UIButton(type: .custom)
    var topBanner: UIView = UIView()
    let collectionTopV = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addNotificationObserver()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addNotificationObserver() {
        
        NotificationCenter.default.nok.observe(name: .pi_noti_coinChange) {[weak self] _ in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.topCoinLabel.text = ( "\(GPyymCoinManagr.default.coinCount)")
            }
        }
        .invalidated(by: pool)
        
    }

}

extension DIyStoreVC {
   
    
    func setupView() {
         
        view.backgroundColor(.white)
        //
        let bgImgV = UIImageView()
        bgImgV.backgroundColor(UIColor(hexString: "#FFF4FC")!)
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: view)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        //
        let topImgV = UIImageView()
        topImgV.image("comobo_bg")
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: view)
        topImgV.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(14)
            $0.width.equalTo(213)
            $0.height.equalTo(75)
        }
        
        //
        let topTitleLabel = UILabel()
        topTitleLabel
            .color(.black)
            .text("Store")
            .fontName(24, "Avenir-BlackOblique")
            .adhere(toSuperview: view)
        topTitleLabel.snp.makeConstraints {
            $0.top.equalTo(topImgV.snp.centerY)
            $0.right.equalTo(topImgV.snp.right)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        backBtn.image(UIImage(named: "back"))
            .adhere(toSuperview: view)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(34)
            $0.left.equalToSuperview().offset(20)
            $0.width.height.equalTo(40)
        }
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        
        //
        collectionTopV.backgroundColor(UIColor.clear)
            
        
        //
        //
        let topCoinImgV = UIImageView()
        topCoinImgV
            .image("popup_heart_ic")
            .adhere(toSuperview: collectionTopV)
        topCoinImgV.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(96)
            $0.height.greaterThanOrEqualTo(96)
        }
        //
        topCoinLabel
            .fontName(16, "Avenir-Black")
            .color(UIColor.black)
            .adhere(toSuperview: collectionTopV)
        topCoinLabel.text = ( "\(GPyymCoinManagr.default.coinCount)")
        topCoinLabel.snp.makeConstraints {
            $0.top.equalTo(topCoinImgV.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.greaterThanOrEqualTo(1)
            $0.height.greaterThanOrEqualTo(40)
        }
        
        // collection
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.layer.masksToBounds = true
        collection.delegate = self
        collection.dataSource = self
//        collection.bounces = false
        
        view.addSubview(collection)
        collection.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(backBtn.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        collection.register(cellWithClass: PCoymStoreCell.self)
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        //
        collectionTopV
            .adhere(toSuperview: collection)
        collectionTopV.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220)
        
        //
        let bottomM = UIView()
        bottomM
            .backgroundColor(.white)
            .adhere(toSuperview: view)
        bottomM.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(collection.snp.bottom)
        }
        
//        collection.addSubview(collectionTopV)
//        collectionTopV.snp.makeConstraints {
//            $0.width
//        }
        
    }
    
}

extension DIyStoreVC {
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
     
    @objc func topCoinBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(DIyStoreVC(), animated: true)
    }
}



extension DIyStoreVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: PCoymStoreCell.self, for: indexPath)
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        let item = GPyymCoinManagr.default.coinIpaItemList[indexPath.item]
        cell.coinCountLabel.text = "x\(item.coin)"
        if let localPrice = item.localPrice {
            cell.priceLabel.text = item.localPrice
        } else {
            cell.priceLabel.text = "$\(item.price)"
//            let str = "$\(item.price)"
//            let att = NSMutableAttributedString(string: str, attributes: [NSAttributedString.Key.font : UIFont(name: "MarkerFelt-Wide", size: 16) ?? UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.black])
//            let ran1 = str.range(of: "$")
//            let ran1n = "".nsRange(from: ran1!)
//            att.addAttributes([NSAttributedString.Key.font : UIFont(name: "MarkerFelt-Wide", size: 32) ?? UIFont.systemFont(ofSize: 16)], range: ran1n)
//            cell.priceLabel.attributedText = att
            
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GPyymCoinManagr.default.coinIpaItemList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension DIyStoreVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let cellwidth: CGFloat = UIScreen.width - (20 * 2)
        let cellHeight: CGFloat = 118
        
        return CGSize(width: cellwidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let cellwidth: CGFloat = 343
        let left: CGFloat = 20//(UIScreen.main.bounds.width - cellwidth - 1) / 2
        
        
        return UIEdgeInsets(top: 20, left: left, bottom: 50, right: left)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let cellwidth: CGFloat = 343
        let left: CGFloat = (UIScreen.main.bounds.width - cellwidth - 1) / 2
        return 18 //left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellwidth: CGFloat = 343
        let left: CGFloat = (UIScreen.main.bounds.width - cellwidth - 1) / 2
        return 18 //left
    }
    
//    referenceSizeForHeaderInSection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: UIScreen.width, height: 182)
//        return CGSize(width: UIScreen.width, height: 0)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader", for: indexPath)
            
            return view
        }
        return UICollectionReusableView()
    }
    
}

extension DIyStoreVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = GPyymCoinManagr.default.coinIpaItemList[safe: indexPath.item] {
            selectCoinItem(item: item)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func selectCoinItem(item: EHmmInCyStoreItem) {
        // core
        
        EHmmyPurchaseManagerLink.default.purchaseIapId(item: item) { (success, errorString) in
            
            if success {
                ZKProgressHUD.showSuccess("Purchase successful.")
            } else {
                ZKProgressHUD.showError("Purchase failed.")
            }
        }
    }
    
}

class PCoymStoreCell: UICollectionViewCell {
    
    var bgView: UIView = UIView()
    
    var iconImageV: UIImageView = UIImageView()
    var coverImageV: UIImageView = UIImageView()
    var coinCountLabel: UILabel = UILabel()
    var priceLabel: UILabel = UILabel()
    var priceBgImgV: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setupView() {
//        
//        let bgImgV = UIImageView()
//        bgImgV
// //           .image("save_btn_bg")
//             .backgroundColor(UIColor(hexString: "#FFFFFF")!)
//            .adhere(toSuperview: self)
//            .contentMode(.scaleAspectFit)
//        
//        bgImgV.snp.makeConstraints {
//            $0.left.right.top.bottom.equalToSuperview()
//        }
//        bgImgV.layer.cornerRadius = 10
//        bgImgV.layer.masksToBounds = true
//        //
//        nameLa
//            .fontName(16, "Avenir-Black")
//            .color(.black)
//            .text("")
//            .numberOfLines(1)
//            .textAlignment(.center)
//            .adhere(toSuperview: self)
//        nameLa.snp.makeConstraints {
//            $0.left.equalTo(25)
//            $0.bottom.equalTo(self.snp.centerY).offset(-14)
//            $0.width.height.greaterThanOrEqualTo(15)
//        }
//        
//        
//        //
//        //
// //       let nextBtn = UIButton()
// //       nextBtn.adhere(toSuperview: self)
// //       nextBtn.snp.makeConstraints {
// //           $0.bottom.equalToSuperview().offset(-10)
// //           $0.centerX.equalToSuperview()
// //           $0.width.equalTo(100)
// //           $0.height.equalTo(46)
// //       }
// //       nextBtn.addTarget(self, action: #selector(nextBtnClick(sender: )), for: .touchUpInside)
//        //
//        
//        
//        
//    }
    
    
    func setupView() {
        
        contentView.backgroundColor =  UIColor(hexString: "#FFFFFF")
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
//        let bgImgV = UIImageView()
//        bgImgV.image("store_coins_bg")
//            .adhere(toSuperview: contentView)
//        bgImgV.snp.makeConstraints {
//            $0.left.right.top.bottom.equalToSuperview()
//        }
        
//        layer.cornerRadius = 12
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.black.cgColor
        
        //
        coinCountLabel
            .fontName(16, "Avenir-Black")
            .color(.black)
            .text("")
            .numberOfLines(1)
            .textAlignment(.center)
            .adhere(toSuperview: self)
        coinCountLabel.snp.makeConstraints {
            $0.left.equalTo(55)
            $0.bottom.equalTo(self.snp.centerY).offset(-14)
            $0.width.height.greaterThanOrEqualTo(15)
        }
        
        //
        iconImageV.backgroundColor = .clear
        iconImageV.contentMode = .scaleAspectFit
        iconImageV.image = UIImage(named: "coppy_pro")
        contentView.addSubview(iconImageV)
        iconImageV.snp.makeConstraints {
            $0.centerY.equalTo(coinCountLabel.snp.centerY)
            $0.right.equalTo(coinCountLabel.snp.left).offset(-5)
            $0.width.equalTo(22)
            $0.height.equalTo(22)
            
        }
         
        //
        let bottomLine = UIView()
        bottomLine.backgroundColor(UIColor(hexString: "#F0F0F0")!)
            .adhere(toSuperview: self)
        bottomLine.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        //
//        coinCountLabel.adjustsFontSizeToFitWidth = true
//        coinCountLabel
//            .color(UIColor(hexString: "#FFFFFF")!)
//            .numberOfLines(1)
//            .fontName(20, "GillSans-SemiBold")
//            .textAlignment(.left)
//            .adhere(toSuperview: contentView)
//        coinCountLabel.snp.makeConstraints {
//            $0.centerY.equalTo(iconImageV.snp.centerY)
//            $0.left.equalTo(iconImageV.snp.right).offset(15)
//            $0.width.height.greaterThanOrEqualTo(24)
//        }
        
        let moreIconImgV = UIImageView()
        moreIconImgV.image("next_ic")
            .adhere(toSuperview: self)
            .contentMode(.center)
        moreIconImgV.snp.makeConstraints {
            $0.top.equalTo(bottomLine.snp.bottom).offset(24)
            $0.right.equalToSuperview().offset(-20)
            $0.width.height.equalTo(11)
        }
        //
//        let moreLabel = UILabel()
//        moreLabel.fontName(12, "Avenir-Black")
//            .color(UIColor(hexString: "#252525")!)
//            .text("Next")
//            .adhere(toSuperview: self)
//
        
        let priceBgV = UIView()
        priceBgV
            .backgroundColor(UIColor.clear)
            .adhere(toSuperview: contentView)
        priceBgV.layer.cornerRadius = 18
        //
        priceBgImgV.image("")
            .adhere(toSuperview: priceBgV)
        priceBgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalTo(priceBgV)
        }
        //
        priceLabel.textColor = UIColor(hexString: "#FF30AD")
        priceLabel.font = UIFont(name: "Avenir-Black", size: 16)
        priceLabel.textAlignment = .center
        contentView.addSubview(priceLabel)
        priceLabel.adjustsFontSizeToFitWidth = true
       
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(moreIconImgV.snp.centerY)
            $0.right.equalTo(moreIconImgV.snp.left).offset(-5)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        priceBgV.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.top).offset(0)
            $0.left.equalTo(priceLabel.snp.left).offset(-16)
            $0.bottom.equalTo(priceLabel.snp.bottom).offset(0)
            $0.right.equalTo(priceLabel.snp.right).offset(16)
        }
        
        
        
    }
     
}




