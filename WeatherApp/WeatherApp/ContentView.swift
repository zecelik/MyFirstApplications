import SwiftUI

struct SplashScreen: View {
    @State private var isActive: Bool = false

    var body: some View {
        ZStack {
     
            Color.blue.opacity(0.6)
    
            VStack {
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)
                Text("WeatherApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            ContentView()
        }
    }
}
struct ContentView: View {
    @State private var city: String = "Istanbul"
    @State private var weatherResponse: WeatherResponse?
    @State private var isLoading: Bool = false
    
    let weatherDescriptions: [String: String] = [
        "Clear": "Açık",
        "Clouds": "Bulutlu",
        "Rain": "Yağmur",
        "Drizzle": "Sıcak Yağmur",
        "Thunderstorm": "Fırtına",
    ]
    
    func backgroundImage(for weather: String) -> String {
        switch weather {
        case "Clear":
            return "clear_sky"
        case "Clouds":
            return "cloudy"
        case "Rain", "Drizzle":
            return "rainy"
        case "Thunderstorm":
            return "thunderstorm"
        default:
            return "default_weather"
        }
    }

    var body: some View {
        ZStack {
            if let weather = weatherResponse?.weather.first?.main {
                Image(backgroundImage(for: weather))
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                Image("default_weather")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 40) {
            
                TextField("Şehir girin", text: $city)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button(action: {
                    fetchWeather()
                }) {
                    Text("Hava Durumunu Al")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                        .frame(width : 180)
                }
                
                if isLoading {
                    ProgressView()
                } else if let weather = weatherResponse {
                    VStack {
                        Text("Sıcaklık: \(weather.main.temp)°C")
                            .font(.largeTitle)
                        if let englishDescription = weather.weather.first?.main {
                            let turkishDescription = weatherDescriptions[englishDescription] ?? "Bilinmiyor"
                            Text("Hava Durumu: \(turkishDescription)")
                        } else {
                            Text("Hava Durumu: N/A")
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                }
            }
            .padding()
        }
    }
    
    private func fetchWeather() {
        isLoading = true
        WeatherService().fetchWeather(for: city) { result in
            DispatchQueue.main.async {
                self.weatherResponse = result
                self.isLoading = false
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
