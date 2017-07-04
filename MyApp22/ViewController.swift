//
//  ViewController.swift
//  MyApp22
//
//  Created by user on 2017/7/4.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController,MPMediaPickerControllerDelegate{

    var palyer:AVAudioPlayer?
    var isplyer:Bool = false
    var count:Float = 0.0
    var len:Float = 100.0
    
    @IBAction func start(_ sender: Any) {
        if isplyer{
            palyer?.play()
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {(timer) in
                DispatchQueue.main.async {
                    self.svw.value = Float((self.palyer?.currentTime)!)
                }
                
            
            })
        }
    }
    
    
    @IBAction func pause(_ sender: Any) {
        if isplyer && (palyer?.isPlaying)!{
            palyer?.stop()
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        if isplyer && (palyer?.isPlaying)!{
            palyer?.pause()
        }
    }
    @IBOutlet weak var pvw: UIProgressView!
    
    @IBOutlet weak var svw: UISlider!
    @IBAction func go(_ sender: Any) {
        pvw.progress = 0  //float 0~1
        var myTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {(timer) in
            self.count += 5.0
            self.showprag()
        })
    }
    func showprag(){
        DispatchQueue.main.async {
            
            self.pvw.progress = self.count / self.len
        }
    }
    
    @IBAction func getmedia(_ sender: Any) {
        let picker = MPMediaPickerController(mediaTypes: .music)
        picker.allowsPickingMultipleItems = true
        picker.delegate = self
        show(picker,sender: self)
        
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        print("ok")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = Bundle.main.url(forResource: "SS", withExtension: "mp3")
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try palyer = AVAudioPlayer(contentsOf: url!)
            
            if (palyer?.prepareToPlay())!{
                palyer?.play()
                isplyer = true
                
                svw.minimumValue = 0
                svw.maximumValue = Float(palyer!.duration)
                svw.value = 0
                
                
                
                print("OK")
            }else{
                isplyer = false
            }
        }catch{
            print(error)
        }
        
        var myProgvw = UIProgressView(progressViewStyle: .default)
        myProgvw.tintColor = UIColor.red
        myProgvw.trackTintColor = UIColor.cyan
        myProgvw.frame = CGRect(x: 0, y: 0, width: 100, height: 10)
        view.addSubview(myProgvw)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

