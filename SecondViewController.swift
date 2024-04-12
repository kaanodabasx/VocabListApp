import UIKit
import AVFoundation

class SecondViewController: UIViewController {
    var TFLabel: UILabel!
    var WordLabel: UILabel!
    var sentenceLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    var audioPlayer: AVAudioPlayer?
    
    let green = UIColor(hex: 0x008C72)
    var wordIndex = 0
    var wordData: [[String: String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.jpg") // "background.jpg" dosyanızın adını kullanın
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        loadWordDataFromGitHub()
        
        let customBackgroundColor = UIColor(hex: 0xD9B4A3)
        let newcolor = UIColor(hex: 0xF1EEDB)
        
        view.backgroundColor = customBackgroundColor
        super.viewDidLoad()
        // Always adopt a light interface style.
        overrideUserInterfaceStyle = .light
        
        TFLabel = UILabel()
        TFLabel.translatesAutoresizingMaskIntoConstraints = false
        TFLabel.textColor = green
        TFLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        WordLabel = UILabel()
        WordLabel.translatesAutoresizingMaskIntoConstraints = false
        WordLabel.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(WordLabel)
                
        // sentenceLabel oluşturma ve ayarlama
        sentenceLabel = UILabel()
        sentenceLabel.translatesAutoresizingMaskIntoConstraints = false
        // Örneğin, sentenceLabel'ın genişliğini artırmak için
        sentenceLabel.preferredMaxLayoutWidth = 240 // Daha büyük bir değer seçebilirsiniz
        sentenceLabel.numberOfLines = 5
        sentenceLabel.textAlignment = .center
        view.addSubview(sentenceLabel)
      
        
        view.addSubview(TFLabel)
        
        let frameView = UIView(frame: CGRect(x: 50, y: 220, width: view.bounds.width - 100, height: 250))
        frameView.layer.borderColor = UIColor.black.cgColor
        frameView.layer.borderWidth = 0.01
        frameView.layer.cornerRadius = 12
        frameView.layer.backgroundColor = newcolor.cgColor
        
        frameView.layer.shadowColor = UIColor.black.cgColor
        frameView.layer.shadowOpacity = 0.20
        frameView.layer.shadowOffset = CGSize(width: -1, height: 2)
        frameView.layer.shadowRadius = 5
        frameView.center.x = view.center.x

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(frameViewTapped))
        frameView.addGestureRecognizer(tapGesture)
        
        view.addSubview(frameView)
        
        // Gölge efekti ekle
        label1.layer.shadowColor = UIColor.black.cgColor
        label1.layer.shadowOpacity = 0.2
        label1.layer.shadowOffset = CGSize(width: 2, height: 2)
        label1.layer.shadowRadius = 10

        label2.layer.shadowColor = UIColor.black.cgColor
        label2.layer.shadowOpacity = 0.2
        label2.layer.shadowOffset = CGSize(width: 2, height: 2)
        label2.layer.shadowRadius = 10
        
        label3.layer.shadowColor = UIColor.black.cgColor
        label3.layer.shadowOpacity = 0.2
        label3.layer.shadowOffset = CGSize(width: 2, height: 2)
        label3.layer.shadowRadius = 10

        // Köşeleri yuvarlat
        label1.layer.cornerRadius = 12
        label2.layer.cornerRadius = 12
        label3.layer.cornerRadius = 12

        // Arkaplan rengini ayarla
        label1.backgroundColor = newcolor
        label2.backgroundColor = newcolor
        label3.backgroundColor = newcolor
        

        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(label1Tapped))
        label1.addGestureRecognizer(tapGesture1)
        label1.isUserInteractionEnabled = true

        // label2 tıklandığında
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(label2Tapped))
        label2.addGestureRecognizer(tapGesture2)
        label2.isUserInteractionEnabled = true
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(label3Tapped))
        label3.addGestureRecognizer(tapGesture3)
        label3.isUserInteractionEnabled = true

        
        NSLayoutConstraint.activate([
        WordLabel.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 40),
        WordLabel.centerXAnchor.constraint(equalTo: frameView.centerXAnchor)
    ])
        
        NSLayoutConstraint.activate([
        sentenceLabel.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 100),
        sentenceLabel.centerXAnchor.constraint(equalTo: frameView.centerXAnchor)
    ])
        frameView.addSubview(WordLabel)
        frameView.addSubview(sentenceLabel)
        
        NSLayoutConstraint.activate([
        TFLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
        TFLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
    ])
        view.addSubview(TFLabel)
        view.bringSubviewToFront(TFLabel)


       
    }
    
    @IBAction func NextWordButton(_ sender: Any) {
        checkMatchAndUpdateUI()
        displayRandomWord()
    }

    @objc func label1Tapped() {
        // TRUE yazısını görüntüle
        if label1.text == wordData[wordIndex]["turkish"] {
            playSound(name: "succes")
            TFLabel.text = "TRUE"
            TFLabel.textColor = green
            TFLabel.font = UIFont.boldSystemFont(ofSize: 30) // Sadece 'text' özelliğine değil, 'font' özelliğine de erişmelisiniz.
            addBounceAnimation2(to: label1)
        } else {
            playSound(name: "wrong")
            addBounceAnimation(to: label1)
            TFLabel.text = "FALSE"
            TFLabel.textColor = .systemRed // Yanlış ise metni kırmızı yapabilirsiniz.
            TFLabel.font = UIFont.boldSystemFont(ofSize: 30)
            frameViewTapped()
        }
        // frameView içeriğini temizle ve frameViewTapped() fonksiyonunu çağır
        
    
    }


    // label2 tıklandığında çalışacak işlem
    @objc func label2Tapped() {
        // TRUE yazısını görüntüle
        if label2.text == wordData[wordIndex]["turkish"] {
            playSound(name: "succes")
            TFLabel.text = "TRUE"
            TFLabel.textColor = green
            TFLabel.font = UIFont.boldSystemFont(ofSize: 30) // Sadece 'text' özelliğine değil, 'font' özelliğine de erişmelisiniz.
            addBounceAnimation2(to: label2)
        } else {
            playSound(name: "wrong")
            addBounceAnimation(to: label2)
            TFLabel.text = "FALSE"
            TFLabel.textColor = .systemRed // Yanlış ise metni kırmızı yapabilirsiniz.
            TFLabel.font = UIFont.boldSystemFont(ofSize: 30)
            frameViewTapped()
        }
        
        // frameView içeriğini temizle ve frameViewTapped() fonksiyonunu çağır
        

        
    }

    @objc func label3Tapped() {
        // TRUE yazısını görüntüle
        if label3.text == wordData[wordIndex]["turkish"] {
            playSound(name: "succes")
            TFLabel.text = "TRUE"
            TFLabel.textColor = green
            TFLabel.font = UIFont.boldSystemFont(ofSize: 30) // Sadece 'text' özelliğine değil, 'font' özelliğine de erişmelisiniz.
            addBounceAnimation2(to: label3)
        } else {
            playSound(name: "wrong")
            addBounceAnimation(to: label3)
            TFLabel.text = "FALSE"
            TFLabel.textColor = .systemRed // Yanlış ise metni kırmızı yapabilirsiniz.
            TFLabel.font = UIFont.boldSystemFont(ofSize: 30)
            frameViewTapped()
        }
        // frameView içeriğini temizle ve frameViewTapped() fonksiyonunu çağır
        
    }
    
    func loadWordDataFromGitHub() {
        let url = URL(string: "https://raw.githubusercontent.com/kaanodabasx/englishwords/main/data.json")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let words = json["words"] as? [[String: String]] {
                        self.wordData = words
                        DispatchQueue.main.async {
                            self.displayRandomWord()
                        }
                    }
                } catch {
                    print("Error loading word data: \(error)")
                }
            }
        }.resume()
    }
    
    func displayRandomWord() {
        if wordData.isEmpty {
            WordLabel.text = "No words available"
            TFLabel.text = ""
            label2.text = "" // Eğer wordData boşsa, label2'yi boşalt
            
            return
        }
        
        wordIndex = Int.random(in: 0..<wordData.count)
        let word = wordData[wordIndex]["english"]
        let sentence = wordData[wordIndex]["sentences"]
        let türkçe = wordData[wordIndex]["turkish"]
        var randomIndex1 = Int.random(in: 0..<wordData.count)
        
        while randomIndex1 == wordIndex {
            randomIndex1 = Int.random(in: 0..<wordData.count)
        }
        
        var randomIndex2 = Int.random(in: 0..<wordData.count)

        while randomIndex2 == wordIndex || randomIndex2 == randomIndex1 {
            randomIndex2 = Int.random(in: 0..<wordData.count)
        }

        let türkçe2 = wordData[randomIndex1]["turkish"]
        let türkçe3 = wordData[randomIndex2]["turkish"]

        
        
        // Create a bold font
        let boldFont = UIFont.boldSystemFont(ofSize: 30) // You can adjust the font size as needed
        
        // Apply the bold font to the WordLabel
        WordLabel.font = boldFont
        WordLabel.text = word
        sentenceLabel.text = sentence
        TFLabel.text = ""
        
        // Rastgele bir sayı oluştur
        let randomInt = Int.random(in: 1...4)
        
        // Oluşturulan sayının çift olup olmadığını kontrol et
        if randomInt == 1 {
            label1.text = türkçe
            label2.text = türkçe2
            label3.text = türkçe3
        } else if randomInt == 2 {
            label1.text = türkçe2
            label2.text = türkçe
            label3.text = türkçe3
        } else {
            label1.text = türkçe3
            label2.text = türkçe2
            label3.text = türkçe
        }
    }
    @objc func frameViewTapped() {
        // frameView içeriğini temizle
        WordLabel.text = wordData[wordIndex]["turkish"]
        

        
        
    }

    
    func checkMatchAndUpdateUI() {
        guard wordIndex < wordData.count else {
            print("No words to check")
            return
        }
        
        let turkishTranslation = wordData[wordIndex]["turkish"]
        
    }
    
    @IBAction func CheckButtonTapped(_ sender: Any) {
        checkMatchAndUpdateUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true) // Klavyeyi kapat
    }
    
    func addBounceAnimation(to label: UILabel) {
        let originalColor = label.textColor

        UIView.animate(withDuration: 0.4, animations:  {
            // Yükselen boyut
            label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            // Kırmızı rengi ayarlayın
            label.textColor = .systemRed
        }) { _ in
            UIView.animate(withDuration: 0.4, animations: {
                // Küçülen boyut (orijinal boyut)
                label.transform = CGAffineTransform.identity
                // Orijinal rengi geri yükleyin
                label.textColor = originalColor
            })
        }
    }
    
    func addBounceAnimation2(to label: UILabel) {
            // İlk olarak, label'in başlangıç rengini saklayın
            let originalColor = label.textColor

            UIView.animate(withDuration: 0.4, animations:  {
                // Yükselen boyut
                label.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                // Kırmızı rengi ayarlayın
                label.textColor = self.green
            }) { _ in
                UIView.animate(withDuration: 0.4, animations: {
                    // Küçülen boyut (orijinal boyut)
                    label.transform = CGAffineTransform.identity
                    // Orijinal rengi geri yükleyin
                    label.textColor = originalColor
                })
            }
        }

    func playSound(name: String) {
        let soundFileName = String(name) // Ses dosyanızın adını buraya yazın (uzantıyı dahil etmeyin)
        if let soundFilePath = Bundle.main.path(forResource: soundFileName, ofType: "mp3") { // Ses dosyasının yolunu bulun
            let soundFileURL = URL(fileURLWithPath: soundFilePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL) // AVAudioPlayer ile ses dosyasını yükleyin
                audioPlayer?.play() // Sesi çalın
            } catch {
                print("Ses dosyası yüklenemedi.")
                print(error.localizedDescription) // Print the error message for debugging
            }
        } else {
            print("Ses dosyası bulunamadı.")
        }
    }

    
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex >> 16) & 0xFF) / 255.0,
            green: CGFloat((hex >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hex & 0xFF) / 255.0,
            alpha: alpha
        )
    }
}
