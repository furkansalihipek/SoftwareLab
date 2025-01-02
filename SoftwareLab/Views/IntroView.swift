import SwiftUI

struct IntroView: View {
    @State private var showLogin = false
    @State private var showRegister = false
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Arka plan gradyanı
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 236/255, green: 220/255, blue: 104/255),
                    Color(red: 255/255, green: 178/255, blue: 107/255)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Arka plan şekilleri
            GeometryReader { geometry in
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 200, height: 200)
                    .offset(x: -50, y: -50)
                    .blur(radius: 10)
                
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 150, height: 150)
                    .offset(x: geometry.size.width - 100, y: geometry.size.height - 100)
                    .blur(radius: 8)
            }
            
            VStack(spacing: 40) {
                // Logo ve başlık bölümü
                VStack(spacing: 25) {
                    // Animasyonlu logo
                    Image(systemName: "laptopcomputer")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 10)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                    
                    VStack(spacing: 15) {
                        Text("Software Lab")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Kodlamayı eğlenerek öğren")
                            .font(.title3)
                            .foregroundColor(.white.opacity(0.9))
                    }
                }
                .padding(.top, 60)
                
                Spacer()
                
                // Özellikler listesi
                VStack(alignment: .leading, spacing: 20) {
                    FeatureRow(icon: "star.fill", text: "İnteraktif Dersler")
                    FeatureRow(icon: "gamecontroller.fill", text: "Eğlenceli Pratikler")
                    FeatureRow(icon: "chart.line.uptrend.xyaxis", text: "Kişisel Gelişim Takibi")
                }
                .padding(.horizontal)
                
                Spacer()
                
                // Giriş butonları
                VStack(spacing: 16) {
                    Button(action: { showLogin = true }) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("Giriş Yap")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(Color(red: 236/255, green: 220/255, blue: 104/255))
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
                    }
                    
                    Button(action: { showRegister = true }) {
                        HStack {
                            Image(systemName: "person.badge.plus")
                            Text("Kayıt Ol")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 1)
                        )
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            isAnimating = true
        }
        .fullScreenCover(isPresented: $showLogin) {
            NavigationView {
                ContentView(isLoginMode: true)
            }
        }
        .fullScreenCover(isPresented: $showRegister) {
            NavigationView {
                ContentView(isLoginMode: false)
            }
        }
    }
}

// Özellik satırı için yardımcı görünüm
struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.system(size: 22))
            
            Text(text)
                .foregroundColor(.white)
                .font(.body)
        }
    }
} 
#Preview {
    IntroView()
}
