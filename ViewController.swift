//
//  ViewController.swift
//  VocabList
//
//  Created by Kaan Odabaş on 22.08.2023.
//

import UIKit

class ViewController: UIViewController {

    // ImageView'i sınıf düzeyinde tanımla
    var animatedImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Arka plan resmini ekler
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)

        // Resmin altındaki arka plan rengini ayarlar
        view.backgroundColor = UIColor(hex: 0xD9B4A3)

        // Her zaman açık arayüz temasını ayarla
        overrideUserInterfaceStyle = .light

        // Animasyonlu resmi oluştur ve ekranın solundan başlat
        setupAnimatedImageView()
        startAnimation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Her sayfaya geçildiğinde animasyon başlatılır
        startAnimation()
    }

    func setupAnimatedImageView() {
        // Animasyonlu resmin UIImageView'ini oluştur
        animatedImageView = UIImageView(frame: CGRect(x: 0, y: 400, width: 400, height: 400))
        animatedImageView.image = UIImage(named: "vocapp.jpg")
        animatedImageView.contentMode = .scaleAspectFit
        view.addSubview(animatedImageView)
    }

    func startAnimation() {
        // Keyframe animasyonunu oluştur
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunctions = [CAMediaTimingFunction(name: .linear)]
        animation.values = [0, UIScreen.main.bounds.width - 240, 0, -UIScreen.main.bounds.width + 240] // Sağa 2sn, sola 2sn
        animation.keyTimes = [0, 0.5, 1.0, 1.5] // Toplam döngü süresi 4sn
        animation.duration = 4
        animation.repeatCount = Float.infinity

        // Animasyonu UIImageView'e uygula
        animatedImageView.layer.add(animation, forKey: "horizontalTranslation")

        // Animasyon bitiminde fotoğrafın ekranın solundan çıkmaması için ayarla
        animatedImageView.center = CGPoint(x: 125, y: 250)
    }


    @IBAction func GoToTestVC(_ sender: Any) {
    }
    @IBAction func GoToListVC(_ sender: Any) {
    }
    
}

