//
//  ImageLoadManagable.swift
//  KarrotPortfolio
//
//  Created by temp_name on 12/9/25.
//

import UIKit
import RxSwift

protocol ImageLoadManagable {
    func loadImage(url: String) -> Observable<UIImage?>
}

class ImageLoadManager: ImageLoadManagable {
    
    private let session: URLSession
    
    init() {
        session = URLSession.shared
    }
    
    enum ErrorCase: Error {
        case invalidURL
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
    
    enum ErrorCase: Error {
        case cannotFindBundle
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
