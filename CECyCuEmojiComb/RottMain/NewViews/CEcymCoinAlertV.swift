//
//  CEcymCoinAlertV.swift
//  CECyCuEmojiComb
//
//  Created by Joe on 2022/1/27.
//

import UIKit

class CEcymCoinAlertV: UIView {
    
    var backBtnClickBlock: (()->Void)?
    var okBtnClickBlock: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func backBtnClick(sender: UIButton) {
        backBtnClickBlock?()
    }
    
    func setupView() {
        backgroundColor = UIColor.clear
//        //
//        var blurEffect = UIBlurEffect(style: .light)
//        var blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = self.frame
//        addSubview(blurEffectView)
//        blurEffectView.snp.makeConstraints {
//            $0.left.right.top.bottom.equalToSuperview()
//        }
//
        //
        let bgBtn = UIButton(type: .custom)
        bgBtn
            .image(UIImage(named: ""))
            .adhere(toSuperview: self)
        bgBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        bgBtn.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        
        //
        let contentV = UIView()
            .backgroundColor(UIColor(hexString: "#FFFFFF")!)
            .adhere(toSuperview: self)
//        contentV.layer.cornerRadius = 20
  //      contentV.layer.masksToBounds = true
        contentV.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        contentV.layer.shadowOffset = CGSize(width: 0, height: -1)
        contentV.layer.shadowRadius = 3
        contentV.layer.shadowOpacity = 0.8
//        contentV.layer.borderWidth = 2
//        contentV.layer.borderColor = UIColor.black.cgColor
        contentV.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-313)
        }
        
        //
//        let titLab = UILabel()
//            .text("It costs \(GPyymCoinManagr.default.coinCostCount) Coins to save the photo.")
//            .textAlignment(.center)
//            .numberOfLines(0)
//            .fontName(16, "AvenirNext-DemiBold")
//            .color(UIColor(hexString: "#735950")!)
//            .adhere(toSuperview: contentV)
//
//        titLab.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.centerY.equalTo(contentV.snp.centerY).offset(0)
//            $0.left.equalToSuperview().offset(44)
//            $0.height.greaterThanOrEqualTo(1)
//        }
//        //
//
//        let titLab2 = UILabel()
//            .text("Using paid item will cost \(LPymCoinManagr.default.coinCostCount) coins.")
//            .textAlignment(.center)
//            .numberOfLines(0)
//            .fontName(16, "AvenirNext-Regular")
//            .color(UIColor(hexString: "#454D3D")!.withAlphaComponent(0.6))
//            .adhere(toSuperview: contentV)
//
//        titLab2.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(titLab.snp.bottom).offset(10)
//            $0.left.equalToSuperview().offset(50)
//            $0.height.greaterThanOrEqualTo(1)
//        }
        //
         
//        let coinImgV = UIImageView()
//            .image("payment_diamond")
//            .contentMode(.scaleAspectFit)
//            .adhere(toSuperview: contentV)
//        coinImgV.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.bottom.equalTo(titLab.snp.top).offset(-14)
//            $0.width.equalTo(192/2)
//            $0.height.equalTo(192/2)
//        }
        
        
       
//        //
//
//        let titLab2 = UILabel()
//            .text("Using paid item will cost \(LPymCoinManagr.default.coinCostCount) coins.")
//            .textAlignment(.center)
//            .numberOfLines(0)
//            .fontName(16, "AvenirNext-Regular")
//            .color(UIColor(hexString: "#454D3D")!.withAlphaComponent(0.6))
//            .adhere(toSuperview: contentV)
//
//        titLab2.snp.makeConstraints {
//            $0.centerX.equalToSuperview()
//            $0.top.equalTo(titLab.snp.bottom).offset(10)
//            $0.left.equalToSuperview().offset(50)
//            $0.height.greaterThanOrEqualTo(1)
//        }
        //
        
        let titLab = UILabel()
            .text("It costs \(GPyymCoinManagr.default.coinCostCount) Coins to copy.")
            .textAlignment(.center)
            .numberOfLines(0)
            .fontName(16, "Avenir-Black")
            .color(UIColor(hexString: "#000000")!)
            .adhere(toSuperview: contentV)
        
        titLab.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview().offset(50)
            $0.height.greaterThanOrEqualTo(1)
        }
        
        
        let coinImgV = UIImageView()
            .image("popup_heart_ic")
            .contentMode(.scaleAspectFit)
            .adhere(toSuperview: contentV)
        coinImgV.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(titLab.snp.top).offset(-32)
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
        
        //
        
        
        //AvenirNext-DemiBold
        let okBtn = UIButton(type: .custom)
        okBtn.layer.cornerRadius = 55/2
        okBtn
            .backgroundColor(UIColor(hexString: "#FF8ADB")!)
            .title("Sure")
            .font(16, "Avenir-Black")
            .titleColor(UIColor(hexString: "#000000")!)
            .adhere(toSuperview: contentV)
        okBtn.addTarget(self, action: #selector(okBtnClick(sender:)), for: .touchUpInside)
        okBtn.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-36)
            $0.centerX.equalTo(contentV.snp.centerX)
            $0.width.equalTo(297)
            $0.height.equalTo(55)
        }
        //
        let backBtn = UIButton(type: .custom)
//        backBtn.layer.cornerRadius = 64/2
        backBtn
//            .backgroundColor(UIColor(hexString: "#F1EFEC")!)
//            .title("No")
//            .font(24, "Baskerville-SemiBold")
//            .titleColor(UIColor(hexString: "#2E2926")!)
            .image(UIImage(named: "close_ic"))
            .adhere(toSuperview: contentV)
//        backBtn.layer.borderColor = UIColor.black.cgColor
//        backBtn.layer.borderWidth = 1
        
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        
        backBtn.snp.makeConstraints {
            $0.top.equalTo(contentV.snp.top)
            $0.right.equalTo(contentV.snp.right)
            $0.width.equalTo(44)
            $0.height.equalTo(44)
        }
         
    }
    @objc func okBtnClick(sender: UIButton) {
        okBtnClickBlock?()
    }
  }
