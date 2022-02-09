//
//  CECymDDataM.swift
//  CECyCuEmojiComb
//
//  Created by Joe on 2022/1/27.
//


import Foundation
import SwifterSwift
import UIKit
//import GPUImage
 
//struct EHmmCyStickerItem: Codable {
//    var thumbName: String?
//    var bigName: String?
//    var isPro: Bool?
//
//}
//
//struct EHmmIconModel: Codable {
//    var nameStr: String
//    var bgColorStr: String
//    var stickerList: [EHmmCyStickerItem]
//}


struct CEcyTextModel: Codable {
    var contentStr: String
    var infoStr: String
}




//class GCFilterItem: Codable {
//
//    let filterName : String
//    let type : String
//    let imageName : String
//
//    enum CodingKeys: String, CodingKey {
//        case filterName
//        case type
//        case imageName
//    }
//}
//
class EHmmDataManager: NSObject {
    static let `default` = EHmmDataManager()
    
    
    var cuteStrList: [CEcyTextModel] {
        return EHmmDataManager.default.loadJson([CEcyTextModel].self, name: "cute") ?? []
    }
    
    var textStrList: [CEcyTextModel] {
        return EHmmDataManager.default.loadJson([CEcyTextModel].self, name: "texst") ?? []
    }
    
    var emojiStrList: [CEcyTextModel] {
        return EHmmDataManager.default.loadJson([CEcyTextModel].self, name: "emji") ?? []
    }
    
//    var filterList : [GCFilterItem] {
//        return EHmmDataManager.default.loadPlist([GCFilterItem].self, name: "FilterList") ?? []
//    }
    
//
//    var isSelectColor: UIColor? = nil
//
//
//
//
//    var colorIconItem : EHmmIconModel? {
//        return EHmmDataManager.default.loadJson(EHmmIconModel.self, name: "colorIconList")
//    }
//
//    var paidIconList : [EHmmIconModel] {
//        return EHmmDataManager.default.loadJson([EHmmIconModel].self, name: "paidIconList") ?? []
//    }
//
//    var overlayerList : [EHmmCyStickerItem] {
//        return EHmmDataManager.default.loadJson([EHmmCyStickerItem].self, name: "borderList") ?? []
//    }
//
//    var bgImgList : [EHmmCyStickerItem] {
//        return EHmmDataManager.default.loadJson([EHmmCyStickerItem].self, name: "bgImgList") ?? []
//    }
//
//    var colorList: [String] {
//        return ["#000000", "#FFFFFF", "#3D98E7", "#554BFF", "#DC34DF", "#ED4546", "#FF6B00", "#FFDC4D", "#3AC299", "#D1EAFF", "#A09CE0", "#F07CF2", "#FFBFC0", "#FFD1AF", "#A9E2AB", "#8BE2E8"]
//    }
////    var bgColorList: [String] {
////        return ["#000000", "#FFFFFF", "#3D98E7", "#554BFF", "#DC34DF", "#ED4546", "#FF6B00", "#FFDC4D", "#3AC299", "#D1EAFF", "#A09CE0", "#F07CF2", "#FFBFC0", "#FFD1AF", "#A9E2AB", "#8BE2E8"]
////    }
//
//
//    var textFontList: [String] = ["AvenirNext-Medium", "Chalkboard SE", "Courier", "Futura", "Gill Sans", "Marker Felt", "Baskerville", "Chalkduster",  "Menlo", "Noteworthy", "Papyrus", "Savoye Let"]
//
//    var paidFontList: [String] = ["Chalkduster", "Chalkboard SE", "Courier", "Futura", "Gill Sans", "Marker Felt", "Menlo", "Noteworthy", "Papyrus", "Savoye Let"]
    
    
    
    override init() {
        super.init()
         
        
    }
    
    var cuteitemList: [String] = [
            """
      /)/)
    ( . .)
    ( づ🔪
    """,
            """
     \\___\\
    ꒰ ˶• ༝ - ˶꒱
    ./づ~🍨
    """,
            """
    /)) /((
    ( . .) (. . )
    ( づ💗⊂ )
    """,
                    """
            (/_/)
            ( •-•)<(gimme yo cash)
            />🔪
            """,
                    """
            ૮꒰ ˶• ༝ •˶꒱ა
            ./づᡕᠵ᠊ᡃ࡚ࠢ࠘ ⸝່ࠡࠣ᠊߯᠆ࠣ࠘ᡁࠣ࠘᠊᠊°.~♡︎
            """,
                    """
            🛸　　　 　🌎　°　　🌓　•　　.°•　　　🚀 ✯
            　　　★　*　　　　　°　　　　🛰 　°·　　 🪐
            .　　　•　° ★　•  ☄
            ▁▂▃▄▅▆▇▇▆▅▄▃▁▂.
            """,
                    """
             //___//
            ꒰ ˶• ༝ - ˶꒱
            ./づ~ ☕ tea for you
            """,
                    """
            ૮₍˶ᵔ ᵕ ᵔ˶₎ა
            ./づᡕᠵ᠊ᡃ່࡚ࠢ࠘ ⸝່ࠡࠣ᠊߯᠆ࠣ࠘ᡁࠣ࠘᠊᠊ࠢ࠘𐡏 💗
            ♡Pew pew♡
            """,
                    """
            ——————————
            ┊┊┊┊ ➶ ❁۪ ｡˚ ✧
            ┊┊┊✧ ⁺ ⁺ 　°
            ┊┊❁ུ۪۪♡ ͎. ｡˚ 　　°
            ┊┊.
            ┊ ➶ ｡˚ 　　°
            *. * ·
            ᶤ ᶫᵒᵛᵉᵧₒᵤ<3
            """,
                    """
            .⋆｡⋆ ༶ ⋆˙⊹ع˖⁺ ☁⋆ ୭ .⋆｡⋆༶⋆˙⊹༺⋆｡⋆༶⋆˙⊹⋆ ༶ ⋆❀.⋆｡⋆༶⋆˙⊹❀☆˖⁺ ☁⋆ .⋆｡⋆༶⋆˙⊹❀⋆｡⋆༶⋆˙⊹ପ ૮ ˶ᵔ ᵕ ᵔ˶ ა ଓ ♡.⋆｡⋆ ༶ ⋆˙⊹ع˖⁺ ☁⋆ ୭ .⋆｡⋆༶⋆˙⊹༺⋆｡⋆༶⋆˙⊹⋆ ༶ ⋆❀.⋆｡⋆༶⋆˙⊹❀☆˖⁺ ☁⋆ .⋆｡⋆༶⋆˙⊹❀⋆｡⋆༶⋆˙⊹
            """,
                    """
            A___A
            (ㅇㅅㅇ)
            /   >𓆏
            """,
                    """
             A__A    ✨🎂✨    A__A
            ( •⩊•)   _______   (•⩊• )
            (>🍰>)   |           |   (<🔪<)
            """,
                    """
            (/__/)
            (ù - ú)
            (<  <  )o
            """,
                    """
            ╭╮╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭╮
            ┃┃╱╱╱╱╱╱╱╱╱╱╱╱╱╱┃┃
            ┃┃╭┳━━┳╮╭╮╭┳━━┳┳┫┃
            ┃╰╯┫╭╮┃╰╯╰╯┃╭╮┣╋╋╯
            ┃╭╮┫╭╮┣╮╭╮╭┫╭╮┃┃┣╮
            ╰╯╰┻╯╰╯╰╯╰╯╰╯╰┻┻┻╯
            """,
                    """
            (|⁔ |)
            (> . <)
            """,
                    """
            (//_ //)
            (^w^)
            """
    ]
    
     
    
    
    
    
}

extension EHmmDataManager {
    
}


extension EHmmDataManager {
    func loadJson<T: Codable>(_: T.Type, name: String, type: String = "json") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                return try! JSONDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                debugPrint(error)
            }
        }
        return nil
    }
    
    func loadJson<T: Codable>(_:T.Type, path:String) -> T? {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            do {
                return try PropertyListDecoder().decode(T.self, from: data)
            } catch let error as NSError {
                print(error)
            }
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func loadPlist<T: Codable>(_:T.Type, name:String, type:String = "plist") -> T? {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            return loadJson(T.self, path: path)
        }
        return nil
    }
    
}



public func MyColorFunc(_ red:CGFloat,_ gren:CGFloat,_ blue:CGFloat,_ alpha:CGFloat) -> UIColor? {
    let color:UIColor = UIColor(red: red/255.0, green: gren/255.0, blue: blue/255.0, alpha: alpha)
    return color
}



// filter
//extension EHmmDataManager {
//    func filterOriginalImage(image: UIImage, lookupImgNameStr: String) -> UIImage? {
//
//        if let gpuPic = GPUImagePicture(image: image), let lookupImg = UIImage(named: lookupImgNameStr), let lookupPicture = GPUImagePicture(image: lookupImg) {
//            let lookupFilter = GPUImageLookupFilter()
//
//            gpuPic.addTarget(lookupFilter, atTextureLocation: 0)
//            lookupPicture.addTarget(lookupFilter, atTextureLocation: 1)
//            lookupFilter.intensity = 0.7
//
//            lookupPicture.processImage()
//            gpuPic.processImage()
//            lookupFilter.useNextFrameForImageCapture()
//            let processedImage = lookupFilter.imageFromCurrentFramebuffer()
//            return processedImage
//        } else {
//            return nil
//        }
//        return nil
//    }
//}



