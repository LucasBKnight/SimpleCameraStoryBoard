//
//  ContentView.swift
//  SimpleCameraStoryBoard
//
//  Created by Lucas Knight on 3/13/23.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
struct ContentView: View {
    let context = CIContext()
    @State var selectedImage:UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var displayPickerView = false
    var body: some View {
        NavigationView{
            VStack {
                if let selectedImage = self.selectedImage{
                    
                    Image(uiImage: selectedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(100)
                }
                else
                {
                    Image("photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(100)
                }
                
                HStack{
                    Spacer()
                    Button("Media Library"){
                        self.sourceType = .photoLibrary
                        self.displayPickerView = true
                    }
                    Spacer()
                    Button("Camera"){
                        self.sourceType = .camera
                        self.displayPickerView = true
                    }
                    Spacer()
                }
                Divider()
                HStack{
                    Spacer()
                    Button("Sepia")
                    {
                        if let inputImage = selectedImage{
                            let beginImage = CIImage(image: inputImage)
                            let currentFilter = CIFilter.sepiaTone()
                            currentFilter.inputImage = beginImage
                            currentFilter.intensity = 1
                            guard let outputImage = currentFilter.outputImage else {return}
                            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                                let uiImage = UIImage(cgImage: cgImage)
                                self.selectedImage = uiImage
                            }
                        }
                    }
                    Spacer()
                    Button("Bokeh Blur")
                    {
                        if let inputImage = selectedImage{
                            let beginImage = CIImage(image: inputImage)
                            let currentFilter = CIFilter.bokehBlur()
                            currentFilter.inputImage = beginImage
                            guard let outputImage = currentFilter.outputImage else {return}
                            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                                let uiImage = UIImage(cgImage: cgImage)
                                self.selectedImage = uiImage
                            }
                        }
                    }
                    Spacer()
                    Button("Comic Filter")
                    {
                        if let inputImage = selectedImage{
                            let beginImage = CIImage(image: inputImage)
                            let currentFilter = CIFilter.comicEffect()
                            currentFilter.inputImage = beginImage
                            guard let outputImage = currentFilter.outputImage else {return}
                            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                                let uiImage = UIImage(cgImage: cgImage)
                                self.selectedImage = uiImage
                            }
                        }
                    }
                    Spacer()
                    Button("Crystalize")
                    {
                        if let inputImage = selectedImage{
                            let beginImage = CIImage(image: inputImage)
                            let currentFilter = CIFilter.crystallize()
                            currentFilter.inputImage = beginImage
                            guard let outputImage = currentFilter.outputImage else {return}
                            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent){
                                let uiImage = UIImage(cgImage: cgImage)
                                self.selectedImage = uiImage
                            }
                        }
                    }
                    Spacer()
                    
                }
            }
            .padding()
        } .sheet(isPresented: self.$displayPickerView){
            SwiftUIView(selectedImage:self.$selectedImage, sourceType: self.sourceType)
        }
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
