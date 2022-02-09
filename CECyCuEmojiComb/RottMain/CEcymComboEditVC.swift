//
//  CEcymComboEditVC.swift
//  CECyCuEmojiComb
//
//  Created by Joe on 2022/1/28.
//

import UIKit
import ZKProgressHUD
import DeviceKit
import MaLiang

class CEcymComboEditVC: UIViewController {

    let backBtn = UIButton()
    let contentTextV = UITextView()
    let coinAlertView = CEcymCoinAlertV()
    
    var contentStr: String
    init(contentStr: String) {
        self.contentStr = contentStr
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCoinAlertView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.contentTextV.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.contentTextV.resignFirstResponder()
    }

}


extension CEcymComboEditVC {
    func setupView() {
        
        //
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
        
        backBtn.image(UIImage(named: "back"))
            .adhere(toSuperview: view)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(34)
            $0.left.equalToSuperview().offset(20)
            $0.width.height.equalTo(40)
        }
        backBtn.addTarget(self, action: #selector(backBtnClick(sender: )), for: .touchUpInside)
        
        //
        let contentBgV = UIView()
        contentBgV.backgroundColor(.white)
            .adhere(toSuperview: view)
        contentBgV.snp.makeConstraints {
            $0.left.equalTo(20)
            $0.top.equalTo(backBtn.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
            if Device.current.diagonal <= 4.7 || Device.current.diagonal >= 6.9 {
                $0.height.equalTo(260)
            } else {
                $0.height.equalTo(300)
            }
            
        }
        contentBgV.layer.cornerRadius = 10
        contentBgV.layer.masksToBounds = true
        
        //
        
        //
        let bottomLine = UIView()
        bottomLine.backgroundColor(UIColor(hexString: "#F0F0F0")!)
            .adhere(toSuperview: contentBgV)
        bottomLine.snp.makeConstraints {
            $0.left.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-51)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        //
        let copyBtn = UIButton()
        copyBtn.adhere(toSuperview: contentBgV)
        copyBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-5)
            $0.centerX.equalTo(contentBgV.snp.centerX)
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
        
        //
        
        contentTextV.backgroundColor(.clear)
            .adhere(toSuperview: contentBgV)
        contentTextV.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-60)
        }
        contentTextV.text = contentStr
        contentTextV.font = UIFont(name: "Helvetica", size: 18)
        contentTextV.textColor = .black
        contentTextV.textAlignment = .left
        
    }
    
    
}


extension CEcymComboEditVC {
    
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
                        self.contentTextV.becomeFirstResponder()
                        self.copyAction()
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
                    self.contentTextV.becomeFirstResponder()
                }
            }
        }
        
        
        coinAlertView.backBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.contentTextV.becomeFirstResponder()
            }
            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            } completion: { finished in
                if finished {
                    
                }
            }
        }
        
    }
    
}

extension CEcymComboEditVC {
   @objc func backBtnClick(sender: UIButton) {
       if self.navigationController == nil {
           self.dismiss(animated: true, completion: nil)
       } else {
           self.navigationController?.popViewController()
       }
   }
    
    @objc func copyBtnClick(sender: UIButton) {
        if contentTextV.text == "" {
            ZKProgressHUD.showMessage("Please enter the copied content first.")
            
        } else {
            self.contentTextV.resignFirstResponder()
            showCoinAlertView()
        }
        
        
    }
    
    func copyAction() {
        if contentTextV.text == "" {
            ZKProgressHUD.showMessage("Please enter the copied content first.")
        } else {
            UIPasteboard.general.string = contentTextV.text
            ZKProgressHUD.showSuccess("Copy Successfully!", maskStyle: nil, onlyOnceFont: nil, autoDismissDelay: 1.5, completion: nil)
        }

    }
    
}


