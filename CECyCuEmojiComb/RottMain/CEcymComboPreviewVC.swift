//
//  CEcymComboPreviewVC.swift
//  CECyCuEmojiComb
//
//  Created by Joe on 2022/1/28.
//

import UIKit
import ZKProgressHUD

class CEcymComboPreviewVC: UIViewController {
    var combosList: [CEcyTextModel]
    var collection: UICollectionView!
    let backBtn = UIButton()
    let coinAlertView = CEcymCoinAlertV()
    
    var cellBgImgName: String = ""
    var titleNameStr: String = ""
    
    var currentCopyStr: String = ""
    
    
    init(combosList: [CEcyTextModel]) {
        self.combosList = combosList
        super.init(nibName: nil, bundle: nil)
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if combosList.first?.contentStr == EHmmDataManager.default.emojiStrList.first?.contentStr {
            cellBgImgName = "emoji_nei_bg"
            titleNameStr = "Emoji Combos"
        } else if combosList.first?.contentStr == EHmmDataManager.default.textStrList.first?.contentStr {
            cellBgImgName = "text_nei_bg"
            titleNameStr = "Text Combos"
        } else {
            cellBgImgName = ""
            titleNameStr = "Cute Combos"
        }
        setupView()
        setupCollection()
        setupCoinAlertView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}


extension CEcymComboPreviewVC {
  
    
    func setupView() {
        view.backgroundColor(.white)
        //
        let bgImgV = UIImageView()
        bgImgV.image("blue_bg_pic")
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
            .text(titleNameStr)
            .fontName(24, "Avenir-BlackOblique")
            .adhere(toSuperview: view)
        topTitleLabel.snp.makeConstraints {
            $0.top.equalTo(topImgV.snp.centerY)
            $0.right.equalTo(topImgV.snp.right)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
         
        //
        
        backBtn.image(UIImage(named: "back"))
            .adhere(toSuperview: view)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(34)
            $0.left.equalToSuperview().offset(20)
            $0.width.height.equalTo(40)
        }
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        
        
    }
    
    func setupCollection() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collection = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
        collection.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.bottom).offset(30)
            $0.bottom.right.left.equalToSuperview()
        }
        collection.register(cellWithClass: CEComboPreviewCell.self)
    }
    
}

extension CEcymComboPreviewVC {
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController()
        }
    }
    
    func updateCurrentEditString(item: CEcyTextModel?) {
        
        var contentStr = item?.contentStr ?? ""
        if combosList.first?.contentStr == EHmmDataManager.default.cuteStrList.first?.contentStr {
            contentStr = EHmmDataManager.default.cuteitemList[item?.contentStr.int ?? 0]
        }
        currentCopyStr = contentStr
    }
    
    func showEditVC(contentStr: String) {
        
        let editVC = CEcymComboEditVC(contentStr: currentCopyStr)
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    func copyCombosAction(contentStr: String) {
        UIPasteboard.general.string = contentStr
        ZKProgressHUD.showSuccess("Copy Successfully!", maskStyle: nil, onlyOnceFont: nil, autoDismissDelay: 1.5, completion: nil)
    }
    
}

extension CEcymComboPreviewVC {
    
    func setupCoinAlertView() {
        
        coinAlertView.alpha = 0
        view.addSubview(coinAlertView)
        coinAlertView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        
    }

    func showCoinAlertView() {
        // show coin alert
        UIView.animate(withDuration: 0.35) {
            self.coinAlertView.alpha = 1
        }
        self.view.bringSubviewToFront(self.coinAlertView)
        coinAlertView.okBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            
            if GPyymCoinManagr.default.coinCount >= GPyymCoinManagr.default.coinCostCount {
                DispatchQueue.main.async {
                     
                    GPyymCoinManagr.default.costCoin(coin: GPyymCoinManagr.default.coinCostCount)
                    DispatchQueue.main.async {
                        self.copyCombosAction(contentStr: self.currentCopyStr)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: "Insufficient Coins, please buy first.", buttonTitles: ["OK"], highlightedButtonIndex: 0) { i in
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let `self` = self else {return}
                            self.navigationController?.pushViewController(DIyStoreVC(), animated: true)
//                            self.present(EHmmStoreeVC(), animated: true, completion: nil)
                        }
                    }
                }
            }

            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            } completion: { finished in
                if finished {
                    
                }
            }
        }
        
        
        coinAlertView.backBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            } completion: { finished in
                if finished {
                    
                }
            }
        }
        
    }
    
}

extension CEcymComboPreviewVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withClass: CEComboPreviewCell.self, for: indexPath)
        let item = combosList[indexPath.item]
        if cellBgImgName == "" {
            cell.contentImgV.image(cellBgImgName)
            cell.contentImgV.backgroundColor(UIColor.white)
        } else {
            cell.contentImgV.image(cellBgImgName)
        }
        cell.comboItem = item
        cell.contentImgV.layer.cornerRadius = 10
        cell.contentImgV.layer.masksToBounds = true
        
        if combosList.first?.contentStr == EHmmDataManager.default.cuteStrList.first?.contentStr {
            let cuteKey = combosList[indexPath.item]
            let contentStr = EHmmDataManager.default.cuteitemList[cuteKey.contentStr.int ?? 0]
            cell.contentTextLabel.text(contentStr)
        } else {
            let contentItem = combosList[indexPath.item]
            cell.contentTextLabel.text(contentItem.contentStr)
        }
        cell.infoLabel2.text(item.infoStr)
        cell.editBtnClickBlock = {
            [weak self] cellCombeItem in
            guard let `self` = self else {return}
            self.updateCurrentEditString(item: cellCombeItem)
            self.showEditVC(contentStr: self.currentCopyStr)
        }
        cell.copyBtnClickBlock = {
            [weak self] cellCombeItem in
            guard let `self` = self else {return}
            self.updateCurrentEditString(item: cellCombeItem)
            self.showCoinAlertView()
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return combosList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension CEcymComboPreviewVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = combosList[indexPath.item]
        var contentStr = item.contentStr
        if combosList.first?.contentStr == EHmmDataManager.default.cuteStrList.first?.contentStr {
            let cuteKey = combosList[indexPath.item]
            contentStr = EHmmDataManager.default.cuteitemList[cuteKey.contentStr.int ?? 0]
        }
        
        let atriStr = NSAttributedString(string: contentStr, attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica", size: 18) ?? UIFont.systemFont(ofSize: 18)])
        
        let size = atriStr.boundingRect(with: CGSize(width: 250, height: CGFloat.infinity), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine], context: nil).size
        let totalHeight: CGFloat = size.height + 90
        
        let width: CGFloat = UIScreen.width - 20 * 2
        
        
        return CGSize(width: width, height: totalHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
    
}

extension CEcymComboPreviewVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
}




class CEComboPreviewCell: UICollectionViewCell {
    let contentImgV = UIImageView()
    let contentTextLabel = UILabel()
    let infoLabel2 = UILabel()
    var comboItem: CEcyTextModel?
    var editBtnClickBlock: ((CEcyTextModel?)->Void)?
    var copyBtnClickBlock: ((CEcyTextModel?)->Void)?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        contentImgV.contentMode = .scaleToFill
        contentImgV.clipsToBounds = true
        contentView.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.top.right.bottom.left.equalToSuperview()
        }
        
        //
        
        contentTextLabel.color(.black)
            .fontName(18, "Helvetica")
            .numberOfLines(0)
            .textAlignment(.left)
            .adhere(toSuperview: contentView)
        contentTextLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.left.equalToSuperview().offset(18)
            $0.right.equalToSuperview().offset(-80)
            $0.height.greaterThanOrEqualTo(28)
        }
        
        //
        
        infoLabel2.fontName(11, "Avenir-Black")
            .color(UIColor(hexString: "#D3D3D3")!)
            .numberOfLines()
            .textAlignment(.left)
            .text(comboItem?.infoStr)
            .adhere(toSuperview: self)
        infoLabel2.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.right.equalToSuperview().offset(-28)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        let iconImgV = UIImageView()
        iconImgV.image("faire_ic")
            .adhere(toSuperview: self)
            .contentMode(.center)
        iconImgV.snp.makeConstraints {
            $0.centerY.equalTo(infoLabel2.snp.centerY)
            $0.right.equalTo(infoLabel2.snp.left).offset(-5)
            $0.width.height.equalTo(10)
        }
        
        
        //
        let bottomLine = UIView()
        bottomLine.backgroundColor(UIColor(hexString: "#F0F0F0")!)
            .adhere(toSuperview: self)
        bottomLine.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-51)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        //
        //
        let editBtn = UIButton()
        editBtn.adhere(toSuperview: self)
        editBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-5)
            $0.left.equalTo(contentView.snp.centerX)
            $0.width.equalTo(160)
            $0.height.equalTo(46)
        }
        editBtn.addTarget(self, action: #selector(editBtnClick(sender: )), for: .touchUpInside)
        //
        let editLabel = UILabel()
        editLabel.fontName(12, "Avenir-Black")
            .color(UIColor(hexString: "#252525")!)
            .text("Edit")
            .adhere(toSuperview: editBtn)
        editLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(-9)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        let editIconImgV = UIImageView()
        editIconImgV.image("next_ic")
            .adhere(toSuperview: editBtn)
            .contentMode(.scaleAspectFit)
        editIconImgV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(editLabel.snp.right).offset(5.5)
            $0.width.height.equalTo(11)
        }
        
        //
        let copyBtn = UIButton()
        copyBtn.adhere(toSuperview: self)
        copyBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-5)
            $0.right.equalTo(contentView.snp.centerX)
            $0.width.equalTo(160)
            $0.height.equalTo(46)
        }
        copyBtn.addTarget(self, action: #selector(copyBtnClick(sender: )), for: .touchUpInside)
        //
        let copyLabel = UILabel()
        copyLabel.fontName(12, "Avenir-Black")
            .color(UIColor(hexString: "#252525")!)
            .text("Copy")
            .adhere(toSuperview: copyBtn)
        copyLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(-9)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        let vipIconImgV = UIImageView()
        vipIconImgV.image("coppy_pro")
            .adhere(toSuperview: copyBtn)
            .contentMode(.scaleAspectFit)
        vipIconImgV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(copyLabel.snp.right).offset(5.5)
            $0.width.height.equalTo(11)
        }
        
        
    }
    
    @objc func editBtnClick(sender: UIButton) {

        editBtnClickBlock?(comboItem)
    }
    
    @objc func copyBtnClick(sender: UIButton) {
        
        copyBtnClickBlock?(comboItem)
    }
    
    
}
