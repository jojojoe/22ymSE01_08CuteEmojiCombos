//
//  CEcymMainVC.swift
//  CECyCuEmojiComb
//
//  Created by Joe on 2022/1/27.
//

import UIKit
import SnapKit
import SwifterSwift
import DeviceKit

class CEcymMainVC: UIViewController {

    let cutePreBtn = CEcymMainPreBtn(frame: .zero, titStr: "Cute\nCombos", bgImgStr: "cute_co_item", infoItemLIst: EHmmDataManager.default.cuteStrList)
    let textPreBtn = CEcymMainPreBtn(frame: .zero, titStr: "Text\nCombos", bgImgStr: "text_co_item", infoItemLIst: EHmmDataManager.default.textStrList)
    let emojiPreBtn = CEcymMainPreBtn(frame: .zero, titStr: "Emoji\nCombos", bgImgStr: "emoji_co_item", infoItemLIst: EHmmDataManager.default.emojiStrList)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AFlyerLibManage.event_LaunchApp()
        setupView()
        setupScroll()
    }
    
    

}

extension CEcymMainVC {
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
            $0.left.equalToSuperview().offset(22)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(34)
            $0.width.equalTo(213)
            $0.height.equalTo(75)
        }
        
        //
        let topTitleLabel = UILabel()
        topTitleLabel
            .color(.black)
            .text("Combos Encyclopedia")
            .fontName(22, "Avenir-BlackOblique")
            .adhere(toSuperview: view)
        if Device.current.diagonal <= 4.7 || Device.current.diagonal >= 6.9 {
            topTitleLabel
                .fontName(20, "Avenir-BlackOblique")
        }
        topTitleLabel.snp.makeConstraints {
            $0.top.equalTo(topImgV.snp.centerY)
            $0.left.equalTo(topImgV.snp.left)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        let btnBgV = UIView()
        btnBgV.backgroundColor(.white)
            .adhere(toSuperview: view)
        btnBgV.snp.makeConstraints {
            $0.centerY.equalTo(topTitleLabel.snp.centerY)
            $0.right.equalToSuperview().offset(-24)
            $0.width.equalTo(88)
            $0.height.equalTo(40)
        }
        btnBgV.layer.cornerRadius = 10
        btnBgV.layer.masksToBounds = true
        //
        let btnLine = UIView()
        btnLine.backgroundColor(UIColor(hexString: "#979797")!)
            .adhere(toSuperview: btnBgV)
        btnLine.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(25)
        }
        
        //
        let storeBtn = UIButton()
        storeBtn.image(UIImage(named: "store"))
            .adhere(toSuperview: btnBgV)
        storeBtn.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()
            $0.right.equalTo(btnLine.snp.left)
        }
        storeBtn.addTarget(self, action: #selector(storeBtnClick(sender:)), for: .touchUpInside)
        
        //
        let settingBtn = UIButton()
        settingBtn.image(UIImage(named: "setting"))
            .adhere(toSuperview: btnBgV)
        settingBtn.snp.makeConstraints {
            $0.right.top.bottom.equalToSuperview()
            $0.left.equalTo(btnLine.snp.left)
        }
        settingBtn.addTarget(self, action: #selector(settingBtnClick(sender: )), for: .touchUpInside)
        
        
    }
    
    @objc func settingBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(CEcymSettingVC(), animated: true)
    }
    @objc func storeBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(DIyStoreVC(), animated: true)
        
    }
    
    
    func setupScroll() {
        
        let previewScroll = UIScrollView()
        previewScroll.backgroundColor(.clear)
            .adhere(toSuperview: view)
        
        previewScroll.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(135)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(UIScreen.width)
            
        }
        
        //
        let left: CGFloat = 21
        let padding: CGFloat = 8
        let cellwidth: CGFloat = (UIScreen.width - left * 2 - padding * 2) / 3
        let cellheight: CGFloat = cellwidth * (304/212)
         
        
        previewScroll.contentSize = CGSize(width: UIScreen.width, height: cellheight + 24 * 3 + 213 * 2)
        
        
        //
        
        cutePreBtn.adhere(toSuperview: previewScroll)
        cutePreBtn.snp.makeConstraints {
            $0.left.equalToSuperview().offset(left)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(cellwidth)
            $0.height.equalTo(cellheight)
        }
        cutePreBtn.addTarget(self, action: #selector(mainPreBtnClick(sender: )), for: .touchUpInside)
        
        //
        
        textPreBtn.adhere(toSuperview: previewScroll)
        textPreBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(cellwidth)
            $0.height.equalTo(cellheight)
        }
        textPreBtn.addTarget(self, action: #selector(mainPreBtnClick(sender: )), for: .touchUpInside)
        
        //
        
        emojiPreBtn.adhere(toSuperview: previewScroll)
        emojiPreBtn.snp.makeConstraints {
            $0.left.equalTo(textPreBtn.snp.right).offset(padding)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(cellwidth)
            $0.height.equalTo(cellheight)
        }
        emojiPreBtn.addTarget(self, action: #selector(mainPreBtnClick(sender: )), for: .touchUpInside)
        
        //
        let emojiComBottomV = CEcymMainBottomBtn(frame: .zero, titStr: "Emoji Combos", infoItemLIst: EHmmDataManager.default.emojiStrList, bgImgStr: "emoji_combo_bg", colorStr: "#E39E27")
        emojiComBottomV.adhere(toSuperview: previewScroll)
        emojiComBottomV.snp.makeConstraints {
            $0.left.equalToSuperview().offset(21)
            $0.top.equalTo(cutePreBtn.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(213)
        }
        emojiComBottomV.seemoreBtnClick = {
            [weak self] itemList in
            guard let `self` = self else {return}
            let comboList = EHmmDataManager.default.emojiStrList
            let prevc = CEcymComboPreviewVC(combosList: comboList)
            self.navigationController?.pushViewController(prevc, animated: true)
        }
        emojiComBottomV.contentClick = {
            [weak self] textItem in
            guard let `self` = self else {return}
            let editVC = CEcymComboEditVC(contentStr: textItem.contentStr)
            self.navigationController?.pushViewController(editVC, animated: true)
        }
        
        
        //
        let textComBottomV = CEcymMainBottomBtn(frame: .zero, titStr: "Text Combos", infoItemLIst: EHmmDataManager.default.textStrList, bgImgStr: "text_comobo_bg", colorStr: "#7574E6")
        textComBottomV.adhere(toSuperview: previewScroll)
        textComBottomV.snp.makeConstraints {
            $0.left.equalToSuperview().offset(21)
            $0.top.equalTo(emojiComBottomV.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(213)
        }
        textComBottomV.seemoreBtnClick = {
            [weak self] itemList in
            guard let `self` = self else {return}
            var comboList = EHmmDataManager.default.textStrList
            let prevc = CEcymComboPreviewVC(combosList: comboList)
            self.navigationController?.pushViewController(prevc, animated: true)
        }
        textComBottomV.contentClick = {
            [weak self] textItem in
            guard let `self` = self else {return}
            let editVC = CEcymComboEditVC(contentStr: textItem.contentStr)
            self.navigationController?.pushViewController(editVC, animated: true)
        }
        
    }
    
    
    @objc func mainPreBtnClick(sender: UIButton) {
        var comboList = EHmmDataManager.default.emojiStrList
        if sender == cutePreBtn {
            comboList = EHmmDataManager.default.cuteStrList
        } else if sender == textPreBtn {
            comboList = EHmmDataManager.default.textStrList
        }
        let prevc = CEcymComboPreviewVC(combosList: comboList)
        self.navigationController?.pushViewController(prevc, animated: true)
    }
    
}



class CEcymMainPreBtn: UIButton {
    let bgImgV = UIImageView()
    var titStr: String
    var bgImgStr: String
    var infoItemLIst: [CEcyTextModel]
    init(frame: CGRect, titStr: String, bgImgStr: String, infoItemLIst: [CEcyTextModel]) {
        self.titStr = titStr
        self.bgImgStr = bgImgStr
        self.infoItemLIst = infoItemLIst
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        bgImgV.image(bgImgStr)
            .contentMode(.scaleAspectFill)
            .adhere(toSuperview: self)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        
        let infoLabel = UILabel()
        infoLabel.fontName(10, "Avenir-Medium")
            .color(.white)
            .numberOfLines()
            .textAlignment(.center)
            .text("\(infoItemLIst.count) item")
            .adhere(toSuperview: self)
        infoLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        //
        let titNameL = UILabel()
        titNameL.fontName(14, "Avenir-Black")
            .color(.white)
            .numberOfLines(2)
            .textAlignment(.center)
            .text(titStr)
            .adhere(toSuperview: self)
        titNameL.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(infoLabel.snp.top).offset(-9)
            $0.left.equalTo(20)
            $0.height.greaterThanOrEqualTo(38)
        }
        
        
    }
}


class CEcymMainBottomBtn: UIView {
    let bgImgV = UIImageView()
    var titStr: String
    var infoItemLIst: [CEcyTextModel]
    var colorStr: String
    var bgImgStr: String
    
    
    var seemoreBtnClick: (([CEcyTextModel])->Void)?
    var contentClick: ((CEcyTextModel)->Void)?
    
    
    init(frame: CGRect, titStr: String, infoItemLIst: [CEcyTextModel], bgImgStr: String, colorStr: String) {
        self.titStr = titStr
        self.infoItemLIst = infoItemLIst
        self.bgImgStr = bgImgStr
        self.colorStr = colorStr
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        bgImgV.image(bgImgStr)
            .contentMode(.scaleToFill)
            .adhere(toSuperview: self)
        bgImgV.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        //
        
        
        //
        let titNameL = UILabel()
        titNameL.fontName(14, "Avenir-Black")
            .color(UIColor(hexString: colorStr)!)
            .numberOfLines(1)
            .textAlignment(.left)
            .text(titStr)
            .adhere(toSuperview: self)
        titNameL.snp.makeConstraints {
            $0.left.equalToSuperview().offset(18)
            $0.top.equalToSuperview().offset(18)
            $0.width.height.greaterThanOrEqualTo(20)
        }
        
        let preLabel1 = CEcymMainBottomLineBtn(frame: .zero, texstItem: infoItemLIst[0])
        preLabel1.adhere(toSuperview: self)
        preLabel1.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(titNameL.snp.bottom).offset(8)
            $0.height.equalTo(48)
        }
        preLabel1.addTarget(self, action: #selector(preLabelBtnClick(sender: )), for: .touchUpInside)
        //
        let line = UIView()
        line.backgroundColor(UIColor(hexString: "#F0F0F0")!)
            .adhere(toSuperview: self)
        line.snp.makeConstraints {
            $0.left.equalTo(24)
            $0.top.equalTo(preLabel1.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        
        let preLabel2 = CEcymMainBottomLineBtn(frame: .zero, texstItem: infoItemLIst[1])
        preLabel2.adhere(toSuperview: self)
        preLabel2.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(line.snp.bottom).offset(8)
            $0.height.equalTo(48)
        }
        preLabel2.addTarget(self, action: #selector(preLabelBtnClick(sender: )), for: .touchUpInside)
        //
        let moreBtn = UIButton()
        moreBtn.adhere(toSuperview: self)
        moreBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(46)
        }
        moreBtn.addTarget(self, action: #selector(moreBtnClick(sender: )), for: .touchUpInside)
        //
        let moreLabel = UILabel()
        moreLabel.fontName(12, "Avenir-Black")
            .color(UIColor(hexString: "#252525")!)
            .text("See More")
            .adhere(toSuperview: moreBtn)
        moreLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(-9)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        let moreIconImgV = UIImageView()
        moreIconImgV.image("next_ic")
            .adhere(toSuperview: moreBtn)
            .contentMode(.center)
        moreIconImgV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(moreLabel.snp.right).offset(5.5)
            $0.width.height.equalTo(11)
        }
        
        
        
    }
    
    @objc func moreBtnClick(sender: UIButton) {
        seemoreBtnClick?(infoItemLIst)
    }
    
    @objc func preLabelBtnClick(sender: CEcymMainBottomLineBtn) {
        contentClick?(sender.texstItem)
    }
     
}

class CEcymMainBottomLineBtn: UIButton {
    
    var texstItem: CEcyTextModel
    
    init(frame: CGRect, texstItem: CEcyTextModel) {
        self.texstItem = texstItem
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
         
        //
        
        let infoLabel1 = UILabel()
        infoLabel1.fontName(18, "Avenir-Medium")
            .color(.black)
            .numberOfLines()
            .textAlignment(.left)
            .text(texstItem.contentStr)
            .adhere(toSuperview: self)
        infoLabel1.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(18)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        let infoLabel2 = UILabel()
        infoLabel2.fontName(11, "Avenir-Black")
            .color(UIColor(hexString: "#D3D3D3")!)
            .numberOfLines()
            .textAlignment(.left)
            .text(texstItem.infoStr)
            .adhere(toSuperview: self)
        infoLabel2.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-28)
            $0.width.height.greaterThanOrEqualTo(1)
        }
        
        let iconImgV = UIImageView()
        iconImgV.image("faire_ic")
            .adhere(toSuperview: self)
            .contentMode(.center)
        iconImgV.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalTo(infoLabel2.snp.left).offset(-5)
            $0.width.height.equalTo(10)
        }
        
        
    }
}








