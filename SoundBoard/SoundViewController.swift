//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by usuario on 10/20/21.
//  Copyright © 2021 empresa. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {

    var grabarAudio:AVAudioRecorder?
    var reproducirAudio:AVAudioPlayer?
    var audioURL:URL?
    @IBOutlet weak var grabarButton: UIButton!
    @IBOutlet weak var reproducirButton: UIButton!
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var agregarButton: UIButton!
    @IBAction func grabarTapped(_ sender: Any) {
        if grabarAudio!.isRecording{
            //detener la grabacion
            grabarAudio?.stop()
            //cambiar texto del boton grabar
            grabarButton.setTitle("GRABAR", for: .normal)
        }else{
            //empezar a grabar
            grabarAudio?.record()
            //cambiar el texto del boton grabar a detener
            grabarButton.setTitle("DETENER", for: .normal)
        }
    }
    @IBAction func reproducirTapped(_ sender: Any) {
        do{
            try reproducirAudio = AVAudioPlayer(contentsOf: audioURL!)
            reproducirAudio!.play()
            print("Reproduciendo")
        }catch{
            
        }
    }
    @IBAction func agregarTapped(_ sender: Any) {
    }
    func configurarGrabacion(){
        do{
            //creando sesion de audio
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: [])
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            //creando direccion para el archivo de audio
            let basePath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath,"audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            //impresion de ruta donde seguardan los archivos
            print("********+")
            print(audioURL!)
            print("*********")
            //crear opcions para elgrabador de audio
            var settings:[String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            //crear el objeto de grabacion de audio
            grabarAudio = try AVAudioRecorder(url: audioURL!, settings: settings)
            grabarAudio!.prepareToRecord()
        }catch let error as NSError{
            print(error)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarGrabacion()

    
    }
    

 
}
