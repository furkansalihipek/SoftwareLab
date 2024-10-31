import SwiftUI

struct CreateProfileView: View {
    @State private var ad = ""
    @State private var soyad = ""
    @State private var isLoading = false
    @State private var showValidationError = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()

                Text("Profil Oluştur")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                TextField("Ad", text: $ad)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 30)

                TextField("Soyad", text: $soyad)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 30)

                if showValidationError {
                    Text("Lütfen tüm alanları doldurun.")
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button(action: {
                    if ad.isEmpty || soyad.isEmpty {
                        showValidationError = true
                    } else {
                        showValidationError = false
                    }
                }) {
                    Text("Başla")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 236/255, green: 220/255, blue: 104/255))
                        .cornerRadius(25)
                        .padding(.horizontal, 15)
                }
                .padding(.top, 30)

                if isLoading {
                    ProgressView()
                }

                Spacer()
            }
            .padding(.top, 50)
            .background(Color.clear)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProfileView()
    }
}

