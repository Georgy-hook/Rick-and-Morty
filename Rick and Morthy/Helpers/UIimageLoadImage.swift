//
//  UIimageLoadImage.swift
//  Rick and Morthy
//
//  Created by Georgy on 20.08.2023.
//
import UIKit

extension UIImageView {
    private static var currentUrlKey: Void?
    
    private var currentUrl: URL? {
        get { return objc_getAssociatedObject(self, &Self.currentUrlKey) as? URL }
        set { objc_setAssociatedObject(self, &Self.currentUrlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    func loadImage(from urlString: String, completion: @escaping ((Bool) -> Void)) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        
        // Если текущий URL совпадает с новым URL, пропускаем загрузку
        if let currentUrl = currentUrl, currentUrl == url {
            return
        }
        
        // Устанавливаем новый текущий URL
        currentUrl = url
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    // Проверяем, что текущий URL по-прежнему совпадает с новым URL перед установкой изображения
                    if self.currentUrl == url {
                        self.image = UIImage(data: data)
                        completion(true)
                    }
                }
            }
        }
    }
}

