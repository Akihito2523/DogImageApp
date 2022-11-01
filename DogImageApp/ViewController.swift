//
//  ViewController.swift
//  DogImageApp
//
//  Created by 鳥山彰仁 on 2022/10/31.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    //画像プロパティ
    @IBOutlet weak var dogImageView: UIImageView!
    //dogプロパティ
    @IBOutlet weak var dogProperty: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Reloadボタンを透明
        self.dogProperty.alpha = 0.0
        //apimethodsメソッド呼び出し
        apimethods()
        //reloadDogsメソッド呼び出し
        animation()
    }
    
    //Reloadボタンのアニメーション
    func animation(){
        //Reloadボタンを透明が透明であれば
        if self.dogProperty.alpha == 0.0 {
            //withDuration → アニメーションにかかる時間(1.2秒)
            //delay → アニメーションを遅らせる時間(0.8秒)
            //options →　アニメーション方法(curveLinear:一定速度で移動)
            UIButton.animate(withDuration: 1.0, delay: 1.2, options: .curveLinear, animations: {
                self.dogProperty.alpha = 1.0
            })
        }
    }
    
    //Reloadボタンアクション
    @IBAction func reloadDogs(_ sender: Any) {
        //apimethodsメソッド呼び出し
        apimethods()
    }
    
    func apimethods(){
        //リクエストのURL(DogAPI)の生成
        let url = "https://dog.ceo/api/breeds/image/random"
        //Alamofireを使ってリクエストを送信
        AF.request(
            url
        ).responseDecodable(of: Photo.self) { [self] response in
            //返ってきたレスポンス(response)を場合分けして処理
            switch response.result {
            case .success(let value):
                //DogImageのランダムな写真のURL
                print(value.message)
                //success
                print(value.status)
                //DogImageをimageUrlに代入
                let imageUrl = URL(string: value.message)!
                //Kingfisherを使用して、URLから読み込んできたきた画像をdogImageViewに表示
                //画像の表示変わるたびに1秒のフェードを入れてます
                dogImageView.kf.setImage(with: imageUrl,
                                         options: [.transition(ImageTransition.fade(1))])
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
