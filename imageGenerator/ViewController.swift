//
//  ViewController.swift
//  imageGenerator
//
//  Created by Vijay Lal on 20/07/24.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    let urlString = "https://picsum.photos/600/600"
    lazy var imagedisplay: UIImageView = {
        let imagedisplay = UIImageView()
        imagedisplay.contentMode = .scaleAspectFill
        imagedisplay.backgroundColor = .white
        return imagedisplay
    }()
    lazy var generatebuttonImage: UIButton = {
        let buttonImage = UIButton()
        buttonImage.setTitle("Generate image", for: .normal)
        buttonImage.setTitleColor(.black, for: .normal)
        buttonImage.backgroundColor = .white
        buttonImage.tintColor = .black
        buttonImage.layer.cornerRadius = 30
        buttonImage.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return buttonImage
    }()
    let colorarray:[UIColor] = [.systemPink,.systemBlue,.systemMint,.systemOrange,.systemPurple,.systemYellow,.systemTeal]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addSubview(imagedisplay)
        imagedisplay.frame = CGRect(x:0, y:0 , width:300 ,height:300)
        imagedisplay.center = view.center
       }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(generatebuttonImage)
        generatebuttonImage.frame = CGRect(x: 30, y: view.frame.size.height-150-view.safeAreaInsets.bottom,
                                   width: view.frame.size.width-60,
                                   height: 55)
    }
    @objc func didTapButton() {
        getRandomPhotos()
        view.backgroundColor = colorarray.randomElement()
    }
        func getRandomPhotos() {
            Task.detached { [weak self] in
                guard let unwrappedSelf = self else { return }
                guard let endPointUrl = URL(string: unwrappedSelf.urlString) else { return }
                let (imageData, _) = try await URLSession.shared.data(from: endPointUrl)
                guard let image = UIImage(data: imageData) else { return }
                await unwrappedSelf.addImageToImageView(image: image)
            }
        }
        @MainActor
        func addImageToImageView(image: UIImage) {
            imagedisplay.image = image
        }
}


