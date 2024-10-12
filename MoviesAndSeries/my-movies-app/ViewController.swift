//
//  ViewController.swift
//  my-movies-app
//
//  Created by Zehra on 17.08.2024.
//


import UIKit

class ViewController: UITableViewController {
    
    var movies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var movie: Movie
            
        movie = Movie(title: "Breaking Bad", description: "Breaking Bad, kanser teşhisi konulan lise kimya öğretmeni Walter White'ın, ailesine finansal güvence sağlamak için metamfetamin üretimine başlamasını konu alan bir suç ve dram dizisidir. Dizi, White'ın suç dünyasındaki dönüşümünü ve tehlikeli ortaklıklarını anlatır..", image: UIImage(named: "filme1")!)
        movies.append(movie)
        
        movie = Movie(title: "Star Wars", description: "Star Wars, galaksiler arası bir evrende geçen epik bir bilim kurgu serisidir. Jedi Şövalyeleri, Sith Lordları ve çeşitli uzaylı türler arasında geçen bu hikaye, İmparatorluk ve İsyan arasındaki savaşı, Güç'ün iki zıt tarafı olan karanlık ve aydınlık tarafın mücadelesini konu alır. ", image: UIImage(named: "filme2")!)
        movies.append(movie)
        
        movie = Movie(title: "Incendies", description: "Denis Villeneuve'un yönettiği 2010 yapımı bir drama filmidir. Film, annelerinin vasiyetini yerine getirmek için Orta Doğu'ya giden ikiz kardeşlerin, geçmişlerine dair şok edici sırları keşfetmesini konu alır.", image: UIImage(named: "filme3")!)
        movies.append(movie)
        
        movie = Movie(title: "Prison Break", description: "Dizide, Lincoln Burrows adlı bir adam haksız yere idama mahkum edilir. Kardeşi Michael Scofield ise Lincoln'ü hapishaneden kaçırmak için kasıtlı olarak suç işleyip aynı hapishaneye girer. Michael, zekice planladığı kaçış planını uygularken, karmaşık ve gerilim dolu olaylar zinciri başlar. Dizi, kaçışlar, komplolar ve kardeşlik teması etrafında şekillenir.", image: UIImage(named: "filme4")!)
        movies.append(movie)
        
        movie = Movie(title: "The Lord of the Rings", description: "J.R.R. Tolkien'in aynı adlı romanından uyarlanan epik bir fantastik film üçlemesidir. Orta Dünya'da geçen bu hikaye, güçlü bir yüzüğün yok edilmesi amacıyla bir araya gelen farklı ırkların mücadelesini anlatır. ", image: UIImage(named: "filme5")!)
        movies.append(movie)
        
        movie = Movie(title: "Teen Wolf", description: "lise öğrencisi Scott McCall’ın bir kurt adam tarafından ısırılmasıyla hayatının değişmesini konu alır. Scott, yeni keşfettiği güçleriyle başa çıkmaya çalışırken, aynı zamanda arkadaşlarıyla birlikte kasabalarını tehdit eden doğaüstü yaratıklara karşı savaşır. ", image: UIImage(named: "filme6")!)
        movies.append(movie)
        
        movie = Movie(title: "Hobbit", description: "Hikaye, Bilbo Baggins adlı bir hobbitin, büyücü Gandalf ve bir grup cüceyle birlikte çıktığı macerayı konu alır. Amaçları, cücelerin kayıp krallığı Erebor'u ve Smaug adlı ejderhanın ele geçirdiği hazineyi geri kazanmaktır. ", image: UIImage(named: "filme7")!)
        movies.append(movie)
        
        movie = Movie(title: "Twilight", description: "Stephenie Meyer'in aynı adlı roman serisinden uyarlanan bir romantik-fantastik film serisidir. Hikaye, genç bir kız olan Bella Swan'ın, küçük bir kasabaya taşındıktan sonra gizemli ve çekici vampir Edward Cullen ile tanışmasını konu alır.", image: UIImage(named: "filme8")!)
        movies.append(movie)
        
        movie = Movie(title: "Game of Thrones", description: "George R.R. Martin'in 'Buz ve Ateşin Şarkıs' adlı kitap serisinden uyarlanan, politik entrikalar, güç mücadeleleri ve fantastik unsurlarla dolu bir televizyon dizisidir. Dizi, Westeros adlı kurgusal bir dünyada, farklı soylu ailelerin Demir Taht'ı ele geçirmek için verdikleri savaşları konu alır.", image: UIImage(named: "filme9")!)
        movies.append(movie)
        
        movie = Movie(title: "The Boy in the Striped Pyjamas", description: "John Boyne'un aynı adlı romanından uyarlanan bir film. Film, II. Dünya Savaşı sırasında Nazi Almanyası'nda, Auschwitz toplama kampı yakınında yaşayan sekiz yaşındaki Bruno adlı bir çocuğun, kampta hapsedilen ve çizgili pijamalar giyen Yahudi bir çocuk olan Shmuel ile kurduğu dostluğu anlatır.", image: UIImage(named: "filme10")!)
        movies.append(movie)
        
    }


    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movies[indexPath.row]
        
        let reuseCell = "reuseCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as! MovieCell
        
        let shortDescription = movie.description.prefix(25)
        
        cell.movieImageView.image = movie.image
        cell.titleLabel.text = movie.title
        cell.descriptionLabel.text = String(shortDescription)
        
     
        cell.movieImageView.layer.cornerRadius = 45
        cell.movieImageView.clipsToBounds = true
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "movieDetails" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedMovie = self.movies[indexPath.row]
                let viewControllerDestiny = segue.destination as! MovieDetailsViewController
                
                viewControllerDestiny.movie = selectedMovie
            }
        }
        
    }


}

