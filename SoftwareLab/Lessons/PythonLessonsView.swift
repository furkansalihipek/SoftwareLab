import SwiftUI

struct PythonLessonsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Başlık ve Açıklama
                VStack(alignment: .leading, spacing: 10) {
                    Text("Python Dersleri")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Python programlama dilinin temellerini öğrenin")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                // Dersler Listesi
                LazyVStack(spacing: 15) {
                    PyLessonCard(
                        title: "Python'a Giriş",
                        description: "Python'un temellerini ve kullanım alanlarını öğrenin",
                        duration: "20 dakika",
                        isCompleted: true
                    )
                    
                    PyLessonCard(
                        title: "Değişkenler ve Veri Tipleri",
                        description: "Python'da değişkenler ve temel veri tiplerini öğrenin",
                        duration: "30 dakika",
                        isCompleted: false
                    )
                    
                    PyLessonCard(
                        title: "Koşullu İfadeler",
                        description: "if, elif ve else yapılarını öğrenin",
                        duration: "25 dakika",
                        isCompleted: false
                    )
                    
                    PyLessonCard(
                        title: "Döngüler",
                        description: "for ve while döngülerini kullanın",
                        duration: "35 dakika",
                        isCompleted: false
                    )
                    
                    PyLessonCard(
                        title: "Fonksiyonlar",
                        description: "Fonksiyon tanımlama ve kullanma",
                        duration: "40 dakika",
                        isCompleted: false
                    )
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PyLessonCard: View {
    let title: String
    let description: String
    let duration: String
    let isCompleted: Bool
    
    var body: some View {
        NavigationLink(destination: PyLessonDetailView(title: title)) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isCompleted ? .green : .gray)
                }
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.blue)
                    Text(duration)
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
}

struct PyLessonDetailView: View {
    let title: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                // Ders içeriği buraya gelecek
                Text("Bu dersin içeriği yakında eklenecek...")
                    .padding()
                
                Spacer()
            }
        }
    }
}

struct PythonLessonsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PythonLessonsView()
        }
    }
} 
