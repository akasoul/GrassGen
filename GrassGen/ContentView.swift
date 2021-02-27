//
//  ContentView.swift
//  GrassGen
//
//  Created by Anton Voloshuk on 17.01.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: decoderWrapper
    var body: some View {
        GeometryReader{ g in
            ZStack{
                VStack{
                    ZStack{
                        Rectangle().fill(Color.white).frame(width: 360, height: 360)
                        if(self.model.img != nil){
                            self.model.img!.clipShape(RoundedRectangle(cornerRadius: 50))
                        }
                    }
                    Group{
                        Slider(value: self.$model.inputs[0], in: 0.0...20000.0)
                        Slider(value: self.$model.inputs[1], in: 0.0...20000.0)
                        Slider(value: self.$model.inputs[2], in: 0.0...20000.0)
                        Slider(value: self.$model.inputs[3], in: 0.0...20000.0)
                        Slider(value: self.$model.inputs[4], in: 0.0...20000.0)
                        Slider(value: self.$model.inputs[5], in: 0.0...20000.0)
                        Slider(value: self.$model.inputs[6], in: 0.0...20000.0)
                        Slider(value: self.$model.inputs[7], in: 0.0...20000.0)
                        Slider(value: self.$model.inputs[8], in: 0.0...20000.0)
                        Slider(value: self.$model.inputs[9], in: 0.0...20000.0)
                    }
                }.frame(width:g.size.width*0.9)
            }.frame(width:g.size.width,height:g.size.height)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


