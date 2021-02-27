//
//  decoderWrapper.swift
//  GrassGen
//
//  Created by Anton Voloshuk on 17.01.2021.
//

import Foundation
import CoreML
import SwiftUI
import Combine
import CoreGraphics
import UIKit

class decoderWrapper: ObservableObject{
    let cgfWidth: CGFloat = 360
    let cgfHeight: CGFloat = 360
    @Published var img: Image?
    @Published var inputs = [Double].init(repeating: 0, count: 10){
        didSet{
            DispatchQueue.global().async{
                var output:decoderOutput?
                do{
                    try output = self.model.prediction(input: decoderInput(input1: MLMultiArray(self.inputs)))
                }
                catch{ return }
                
                let out=output?.output1
                let length = out!.count
                let doublePtr =  out!.dataPointer.bindMemory(to: Double.self, capacity: length)
                
                var px:[UInt32] = []
                for i in 0..<360*360{
                    let r = Int(truncating: out![i]) > 255 ? 255 : out![i]
                    let g = Int(truncating: out![360*360+i]) > 255 ? 255 : out![360*360+i]
                    let b = Int(truncating: out![360*360*2+i]) > 255 ? 255 : out![360*360*2+i]
                    let clr=UInt32(truncating: r)<<24 + UInt32(truncating: g)<<16 + UInt32(truncating: b)<<8 + UInt32(255)
                    px.append(clr)
                }
                var mutPixels = px
                let mutBufPtr = UnsafeMutableBufferPointer(start: &mutPixels, count: px.count)
                let context=CGContext(data: mutBufPtr.baseAddress, width: Int(self.cgfWidth), height: Int(self.cgfHeight), bitsPerComponent: 8, bytesPerRow: Int(self.cgfWidth)*4, space: CGColorSpace(name: CGColorSpace.sRGB)!, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)!
                
                let contextImage=context.makeImage()!
                DispatchQueue.main.async{
                    self.img=Image(uiImage: UIImage(cgImage: contextImage))
                }
            }
        }
    }
    let model: decoder = decoder()
    
    init() {
        for i in 0..<self.inputs.count{
            self.inputs[i]=Double.random(in: 0..<20000)
        }
    }
}
