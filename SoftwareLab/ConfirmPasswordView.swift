import SwiftUI

import SwiftUI

struct ConfirmPasswordView: View {
    @State private var ad = ""
    @State private var soyad = ""
    @State private var isLoading = false
    @State private var showValidationError = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()

                Text("Parola Sıfırlama")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)

                TextField("Doğrulama Kodu", text: $ad)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 30)

                TextField("Yeni Parola", text: $soyad)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 30)

                Button(action: {
                    if ad.isEmpty || soyad.isEmpty {
                        showValidationError = true
                    } else {
                        showValidationError = false
                    }
                }) {
                    Text("Onayla")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 70/255, green: 115/255, blue: 161/255))
                        .cornerRadius(25)
                        .padding(.horizontal, 15)
                }
                .padding(.top, 30)

                Spacer()
            }
            .padding(.top, 50)
            .background(Color.clear)
        }
    }
}

#Preview {
    ConfirmPasswordView()
}
