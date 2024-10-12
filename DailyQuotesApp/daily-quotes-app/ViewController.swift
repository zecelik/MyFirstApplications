//
//  ViewController.swift
//  daily-quotes-app
//
//  Created by Zehra on 5.09.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBAction func newQuoteButton(_ sender: Any) {
        
        var quotes: [String] = []
        quotes.append("Hayat bir şeyler hakkında endişelenmek için çok kısa. Bu yüzden her zaman mutlu ol!")
        quotes.append("Hayat sana bin şans verir. Tek yapman gereken bir tane almak ve bu şansa inanmaktır.")
        quotes.append("Nerede olduğun, kim olduğunun bir sonucudur, ama nereye gittiğin tamamen kim olmayı seçtiğine bağlıdır.")
        quotes.append("Tanrı'nın her birimizin içine armağanlar, yetenekler ve kabiliyetler koyduğuna inanıyorum. Bunu geliştirdiğinizde, kendinize inandığınızda ve etkili ve amaçlı bir kişi olduğunuza inandığınızda, her durumdan yükselebileceğinize inanıyorum.   –Joel Osteen")
        quotes.append("Yaşamdaki her şey güzel bir sona sahiptir. Eğer şu an güzel gitmiyorsa, sadece daha güzel bir şeyin başlangıcı olabilir.")
        quotes.append("Hiçbir şey için geç değildir. Ne hayatınızı değiştirmek için ne de mutlu olmak için")
        quotes.append("Hayatta pişmanlık diye birşey yok yalnızca çıkarılan dersler var.")
        quotes.append("Hayat her ne kadar zor görünse de, yapabileceğimiz ve başarabileceğimiz bir şey mutlaka vardır. (Stephen Hawking)")
        quotes.append("Kim olduğunuzu keşfedin ve o kişi olmayı başarın. Ruhunuzun bu dünyada başka bir amacı yok. Hakikatı bulun ve yaşayın geri kalan her şey kendiliğinden gelecektir.")
        quotes.append("Yüzünüzü güneşe döndüğünüz zaman, gölgeler hep arkanızda kalır. ")
        quotes.append("Düşündüğünüz, inandığınız ve güvenle beklediğiniz her şey mutlaka gerçekleşir.   -JackAddington")
        quotes.append("Önünüze çıkan her zorluğun üstesinden gelmek zorunda değilsiniz. Bazen geri çekilip buna ihtiyacınız olup olmadığını sorgulamanız gerekir.   - SachinTendulkar")
        
        
        let number = Int(arc4random_uniform(UInt32(quotes.count)))
             
             quoteLabel.text = quotes[number]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

