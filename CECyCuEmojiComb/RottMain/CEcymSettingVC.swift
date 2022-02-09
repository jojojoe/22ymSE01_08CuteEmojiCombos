//
//  CEcymSettingVC.swift
//  CECyCuEmojiComb
//
//  Created by Joe on 2022/1/27.
//



import UIKit
import MessageUI
import StoreKit
import Defaults
import NoticeObserveKit


class CEcymSettingVC: UIViewController {
   var upVC: UIViewController?
    let backBtn = UIButton()
   let titleLabel = UILabel(text: "Setting")
   let privacyBtn = CEcySettingBtn()
   let termsBtn = CEcySettingBtn()
   let feedbackBtn = CEcySettingBtn()
//    let coinLabel = UILabel()

   var loginBtnClickBlock: (()->Void)?
   
   
   let accountBgView = UIView()
   let coinInfoBgView = UIView()
   let userNameLabel = UILabel()
   override func viewDidLoad() {
       super.viewDidLoad()
       view.backgroundColor = UIColor(hexString: "#FFFFFF")
       setupView()
       setupContent()
//        updateUserAccountStatus()
   }
   
   override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
//        self.coinLabel.text("Your coins: \(InCymCoinManagr.default.coinCount)")
   }
    
}

extension CEcymSettingVC {
    
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
            .text("Setting")
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
   
 
   
   func setupContent() {
       
       // login

//        loginBtn.nameLa.text("Login account")
//        loginBtn.btn.setTitle("Log in", for: .normal)
//        view.addSubview(loginBtn)
//        loginBtn.snp.makeConstraints {
//            $0.width.equalTo(748/2 - 20)
//            $0.height.equalTo(176/2)
//            $0.right.equalToSuperview()
//            $0.top.equalTo(backBtn.snp.bottom).offset(26)
//        }
//        loginBtn.addTarget(self, action: #selector(loginBtnClick(sender:)), for: .touchUpInside)
       
       
        
       
       // feed
       feedbackBtn.nameLa.text("Feedback")
           
       view.addSubview(feedbackBtn)
       feedbackBtn.snp.makeConstraints {
           $0.centerX.equalToSuperview()
           $0.height.equalTo(118)
           $0.left.equalTo(21)
           $0.top.equalTo(backBtn.snp.bottom).offset(44)
       }
       feedbackBtn.addTarget(self, action: #selector(feedbackBtnClick(sender:)), for: .touchUpInside)
       
       
       
       
       // privacy
       privacyBtn.nameLa.text("Privacy Policy")
       view.addSubview(privacyBtn)
       privacyBtn.snp.makeConstraints {
           $0.centerX.equalToSuperview()
           $0.height.equalTo(118)
           $0.left.equalTo(21)
           $0.top.equalTo(feedbackBtn.snp.bottom).offset(18)
       }
       privacyBtn.addTarget(self, action: #selector(privacyBtnClick(sender:)), for: .touchUpInside)
       
       // terms
       
       termsBtn.nameLa.text("Terms of use")
       view.addSubview(termsBtn)
       termsBtn.snp.makeConstraints {
           $0.centerX.equalToSuperview()
           $0.height.equalTo(118)
           $0.left.equalTo(21)
           $0.top.equalTo(privacyBtn.snp.bottom).offset(18)
           
       }
       termsBtn.addTarget(self, action: #selector(termsBtnClick(sender:)), for: .touchUpInside)
       
       
       
       // logout
//        logoutBtn.nameLa.text("")
//        logoutBtn.btn.setTitle("Log out", for: .normal)
//        view.addSubview(logoutBtn)
//        logoutBtn.snp.makeConstraints {
//            $0.width.equalTo(748/2 - 20)
//            $0.height.equalTo(176/2)
//            $0.right.equalToSuperview()
//            $0.top.equalTo(backBtn.snp.bottom).offset(26)
//        }
//        logoutBtn.addTarget(self, action: #selector(logoutBtnClick(sender:)), for: .touchUpInside)
       
       
       
       // user name label
//        view.addSubview(userNameLabel)
//        userNameLabel.textAlignment = .center
//        userNameLabel.adjustsFontSizeToFitWidth = true
//        userNameLabel.textColor = .black
//        userNameLabel.font = UIFont(name: "Avenir-BoldMT", size: 18)
//        userNameLabel.snp.makeConstraints {
//            $0.center.equalTo(titleLabel)
//            $0.height.equalTo(40)
//            $0.left.equalTo(backBtn.snp.right).offset(10)
//        }
//
//
//        // accountBgView
//        accountBgView.backgroundColor = .clear
//        view.addSubview(accountBgView)
//        accountBgView.snp.makeConstraints {
//            $0.center.equalTo(loginBtn)
//            $0.width.equalToSuperview()
//            $0.centerX.equalToSuperview()
//
//        }
//
//        // coin info bg view
//        let topCoinLabel = UILabel()
//        topCoinLabel.textAlignment = .right
//        topCoinLabel.text = "\(InCymCoinManagr.default.coinCount)"
//        topCoinLabel.textColor = UIColor(hexString: "#2A2A2A")
//        topCoinLabel.font = UIFont(name: "PingFangSC-Semibold", size: 22)
//        accountBgView.addSubview(topCoinLabel)
//        topCoinLabel.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.centerX.equalToSuperview().offset(-28)
//            $0.height.equalTo(30)
//            $0.width.greaterThanOrEqualTo(25)
//        }
//
//        let coinImageV = UIImageView()
//        coinImageV.image = UIImage(named: "coins_icon3")
//        coinImageV.contentMode = .scaleAspectFit
//        accountBgView.addSubview(coinImageV)
//        coinImageV.snp.makeConstraints {
//            $0.centerY.equalTo(topCoinLabel)
//            $0.left.equalTo(topCoinLabel.snp.right).offset(10)
//            $0.width.height.equalTo(20)
//        }
       
   }
}

extension CEcymSettingVC {
//    func updateUserAccountStatus() {
//        if let userModel = LoginManage.currentLoginUser() {
//            let userName  = userModel.userName
//            let name = (userName?.count ?? 0) > 0 ? userName : "Signed in with apple ID"
////            accountBgView.isHidden = false
//            logoutBtn.nameLa.text(name)
//            logoutBtn.isHidden = false
//            loginBtn.isHidden = true
//            userNameLabel.isHidden = false
//            titleLabel.isHidden = true
//        } else {
//            logoutBtn.nameLa.text("")
////            accountBgView.isHidden = true
//            logoutBtn.isHidden = true
//            loginBtn.isHidden = false
//            userNameLabel.isHidden = true
//            titleLabel.isHidden = false
//        }
//    }
}

extension CEcymSettingVC {
   @objc func stoerBtnClick(sender: UIButton) {
//        let storeVC = FFyInStoreVC()
//        self.navigationController?.pushViewController(storeVC, animated: true)
   }
}



extension CEcymSettingVC {
   @objc func backBtnClick(sender: UIButton) {
       if self.navigationController == nil {
           self.dismiss(animated: true, completion: nil)
       } else {
           self.navigationController?.popViewController()
       }
   }
}



extension CEcymSettingVC {
   @objc func privacyBtnClick(sender: UIButton) {
       UIApplication.shared.openURL(url: PrivacyPolicyURLStr)
   }
   
   @objc func termsBtnClick(sender: UIButton) {
       UIApplication.shared.openURL(url: TermsofuseURLStr)
   }
   
   @objc func feedbackBtnClick(sender: UIButton) {
       feedback()
   }
   
//    @objc func loginBtnClick(sender: UIButton) {
//        backBtnClick(sender: backBtn)
//        if let mainVC = self.upVC as? HPymMainVC {
//            mainVC.showLoginVC()
//        }
//
//    }
//
//    @objc func logoutBtnClick(sender: UIButton) {
//        LoginManage.shared.logout()
//        updateUserAccountStatus()
//    }
   
   
    
}



extension CEcymSettingVC: MFMailComposeViewControllerDelegate {
   func feedback() {
       //首先要判断设备具不具备发送邮件功能
       if MFMailComposeViewController.canSendMail(){
           //获取系统版本号
           let systemVersion = UIDevice.current.systemVersion
           let modelName = UIDevice.current.modelName
           
           let infoDic = Bundle.main.infoDictionary
           // 获取App的版本号
           let appVersion = infoDic?["CFBundleShortVersionString"] ?? "8.8.8"
           // 获取App的名称
           let appName = "\(AppName)"
           
           
           let controller = MFMailComposeViewController()
           //设置代理
           controller.mailComposeDelegate = self
           //设置主题
           controller.setSubject("\(appName) Feedback")
           //设置收件人
           // FIXME: feed back email
           controller.setToRecipients([feedbackEmail])
           //设置邮件正文内容（支持html）
           controller.setMessageBody("\n\n\nSystem Version：\(systemVersion)\n Device Name：\(modelName)\n App Name：\(appName)\n App Version：\(appVersion )", isHTML: false)
           
           //打开界面
           self.present(controller, animated: true, completion: nil)
       }else{
           HUD.error("The device doesn't support email")
       }
   }
   
   //发送邮件代理方法
   func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
       controller.dismiss(animated: true, completion: nil)
   }
}


class HPymSettingLoginBtn: UIButton {
   
   var nameLa = UILabel()
   let btn = UIButton()
   var btnClickBlock: (()->Void)?
   
   override init(frame: CGRect) {
       super.init(frame: frame)
       
       setupView()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   func setupView() {
       let bgImgV = UIImageView()
       bgImgV
           .image("coin_bg_pic")
           .adhere(toSuperview: self)
           .contentMode(.scaleAspectFit)
       bgImgV.snp.makeConstraints {
           $0.left.right.top.bottom.equalToSuperview()
       }
       //
       nameLa
           .fontName(18, "Avenir-Light")
           .color(.black)
           .text("Login")
           .numberOfLines(2)
           .textAlignment(.left)
           .adhere(toSuperview: self)
       nameLa.snp.makeConstraints {
           $0.left.equalTo(80)
           $0.centerY.equalToSuperview()
           $0.right.equalToSuperview().offset(-150)
           $0.height.greaterThanOrEqualTo(60)
       }
       
       //
       btn.isUserInteractionEnabled(false)
       btn
           .backgroundColor(UIColor(hexString: "#2FDF84")!)
           .titleColor(UIColor.white)
           .font(18, "Didot-Bold")
           .adhere(toSuperview: self)
       btn.snp.makeConstraints {
           $0.centerY.equalToSuperview()
           $0.right.equalToSuperview().offset(-24)
           $0.width.equalTo(85)
           $0.height.equalTo(40)
       }
       btn.layer.cornerRadius = 20
       btn.layer.masksToBounds = true
//        btn.addTarget(self, action: #selector(btnClick(sender: )), for: .touchUpInside)
       
       
   }
   
//    @objc func btnClick(sender: UIButton) {
//        btnClickBlock?()
//    }
   
   
}


class CEcySettingBtn: UIButton {
   
   
   var nameLa = UILabel()
   
   
   override init(frame: CGRect) {
       super.init(frame: frame)
       
       setupView()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   func setupView() {
       
       self.backgroundColor(.clear)
       
       let bgImgV = UIImageView()
       bgImgV
//           .image("save_btn_bg")
            .backgroundColor(UIColor(hexString: "#FFFFFF")!)
           .adhere(toSuperview: self)
           .contentMode(.scaleAspectFit)
       
       bgImgV.snp.makeConstraints {
           $0.left.right.top.bottom.equalToSuperview()
       }
       bgImgV.layer.cornerRadius = 10
       bgImgV.layer.masksToBounds = true
       //
       nameLa
           .fontName(16, "Avenir-Black")
           .color(.black)
           .text("")
           .numberOfLines(1)
           .textAlignment(.center)
           .adhere(toSuperview: self)
       nameLa.snp.makeConstraints {
           $0.left.equalTo(25)
           $0.bottom.equalTo(self.snp.centerY).offset(-14)
           $0.width.height.greaterThanOrEqualTo(15)
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
       //
//       let nextBtn = UIButton()
//       nextBtn.adhere(toSuperview: self)
//       nextBtn.snp.makeConstraints {
//           $0.bottom.equalToSuperview().offset(-10)
//           $0.centerX.equalToSuperview()
//           $0.width.equalTo(100)
//           $0.height.equalTo(46)
//       }
//       nextBtn.addTarget(self, action: #selector(nextBtnClick(sender: )), for: .touchUpInside)
       //
       
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
       let moreLabel = UILabel()
       moreLabel.fontName(12, "Avenir-Black")
           .color(UIColor(hexString: "#252525")!)
           .text("Next")
           .adhere(toSuperview: self)
       moreLabel.snp.makeConstraints {
           $0.centerY.equalTo(moreIconImgV.snp.centerY)
           $0.right.equalTo(moreIconImgV.snp.left).offset(-5)
           $0.width.height.greaterThanOrEqualTo(1)
       }
       
   }
   
   
}

