import SwiftUI
import WebKit

struct YouTubeWebView: UIViewRepresentable {
    var videoURL: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let embedHTML = """
        <html>
        <body style="margin: 0; padding: 0;">
        <iframe width="100%" height="100%" src="\(videoURL)" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
        </body>
        </html>
        """
        
        // HTML içeriği yükle
        uiView.loadHTMLString(embedHTML, baseURL: nil)
    }
}

