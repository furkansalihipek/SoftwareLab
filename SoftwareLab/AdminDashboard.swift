import SwiftUI

struct AdminPanelView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                DashboardView()
                
                HStack(spacing: 20) {
                    NavigationLink(destination: CourseManagementView()) {
                        AdminButton(title: "Kurs Yönetimi", iconName: "book.fill")
                    }
                    NavigationLink(destination: UserManagementView()) {
                        AdminButton(title: "Kullanıcı Yönetimi", iconName: "person.3.fill")
                    }
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Admin Paneli")
        }
    }
}

struct DashboardView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Toplam Kullanıcı")
                    .font(.headline)
                Text("250")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Toplam Kurs")
                    .font(.headline)
                Text("45")
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

struct AdminButton: View {
    let title: String
    let iconName: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(.blue)
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
    }
}

struct CourseManagementView: View {
    var body: some View {
        Text("Kurs Yönetimi")
            .font(.largeTitle)
    }
}

struct UserManagementView: View {
    var body: some View {
        Text("Kullanıcı Yönetimi")
            .font(.largeTitle)
    }
}

struct AdminPanelView_Previews: PreviewProvider {
    static var previews: some View {
        AdminPanelView()
    }
}
