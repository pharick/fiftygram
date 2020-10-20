//
//  ViewController.swift
//  Fiftygram
//
//  Created by Артем Форкунов on 20.10.2020.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let context = CIContext()
    var original: UIImage?
    
    @IBOutlet var imageView: UIImageView!

    @IBAction func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            navigationController?.present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func applySepia() {
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(0.5, forKey: kCIInputIntensityKey)
        display(filter!)
    }
    
    @IBAction func applyNoir() {
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        display(filter!)
    }
    
    @IBAction func applyVintage() {
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        display(filter!)
    }
    
    @IBAction func applyBlur() {
        let filter = CIFilter(name: "CIGaussianBlur")
        display(filter!)
    }

    @IBAction func applyComic() {
        let filter = CIFilter(name: "CIComicEffect")
        display(filter!)
    }
    
    @IBAction func applyCrystallize() {
        let filter = CIFilter(name: "CICrystallize")
        display(filter!)
    }
    
    @IBAction func saveImage() {
        guard let image = imageView.image else {
            return
        }

        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }

    func display(_ filter: CIFilter) {
        guard let original = original else {
            return
        }

        filter.setValue(CIImage(image: original), forKey: kCIInputImageKey)
        let output = filter.outputImage
        imageView.image = UIImage(cgImage: self.context.createCGImage(output!, from: output!.extent)!, scale: original.scale, orientation: original.imageOrientation)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        navigationController?.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            original = image
        }
    }
}

