//
//  ImageLoadManagable.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/9/25.
//

import UIKit
import RxSwift

protocol ImageLoadManagable {
    var imageLoadError: Error { get }
    func loadImage(url: String) -> Observable<UIImage?>
}

class ImageLoadManager: ImageLoadManagable {
    
    private let session: URLSession
    var imageLoadError: Error = ErrorCase.imageLoadError
    
    init() {
        session = URLSession.shared
    }
    
    enum ErrorCase: Error {
        case invalidURL
        case imageLoadError
    }
    
    func loadImage(url: String) -> Observable<UIImage?> {
        guard let validURL = URL(string: url) else {
            return Observable.error(ErrorCase.invalidURL)
        }
        return URLSession.shared.rx.data(
            request: URLRequest(url: validURL))
        .map { UIImage(data: $0) }
        .catchAndReturn(nil)
    }
}

class ImageLoadManagerStub: ImageLoadManagable {
    
    var imageLoadError: Error = ErrorCase.imageLoadError
    
    enum ErrorCase: Error {
        case imageLoadError
        case invalidURL
        case invalidData
    }
    
    func loadImage(url: String) -> Observable<UIImage?> {
        return Observable.create { observer in
            guard let validURL: URL = Bundle.main.url(forResource: url, withExtension: "jpg") else {
                observer.onError(ErrorCase.invalidURL)
                return Disposables.create()
            }
            do {
                let imageData = try Data(contentsOf: validURL)
                let image = UIImage(data: imageData)
                observer.onNext(image)
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
