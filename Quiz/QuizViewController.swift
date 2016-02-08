//
//  QuizViewController.swift
//  Quiz
//
//  Created by ohtatomotaka on 2015/02/10.
//  Copyright (c) 2015年 LifeisTech. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    //クイズを格納する配列
    var quizArray = [AnyObject]()
    
    //正解数
    var correctAnswer:Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButtons1: UIButton!
    @IBOutlet var choiceButtons2: UIButton!
    @IBOutlet var choiceButtons3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tmpArray = [AnyObject]()
        
        //------------------------ここから下にクイズを書く------------------------//
        tmpArray.append(["森泉亮介の誕生日は？","3月12日","3月13日","3月14日",2])
        tmpArray.append(["森泉亮介の嫌いな食べ物は？","セロリ","ブロッコリー","トマト",1])
        tmpArray.append(["森泉亮介はイケメンか？","めっちゃ","まあまあ","そうでもない",1])
        tmpArray.append(["森泉亮介の好きな飲み物は？","コーラ","麦茶","水",2])
        tmpArray.append(["森泉亮介が大学時代に務めていたことは？","TA","SA","PA",2])
        tmpArray.append(["森泉亮介のリュックのメーカーは？","マンハッタンポーテージ","ブルックス","ニクソン",3])
        //------------------------ここから上にクイズを書く------------------------//
        
        // 問題をシャッフルしてquizArrayに格納する
        while (tmpArray.count > 0) {
            let index = Int(arc4random_uniform(UInt32(tmpArray.count)))
            quizArray.append(tmpArray[index])
            tmpArray.removeAtIndex(index)
        }
        choiceQuiz()
    }
    
    func choiceQuiz() {
        quizTextView.text = quizArray[0][0] as! String
        
        //選択肢のボタンにそれぞれ選択肢のテキストをセット
        choiceButtons1.setTitle(quizArray[0][1] as? String, forState: .Normal)
        choiceButtons2.setTitle(quizArray[0][2] as? String, forState: .Normal)
        choiceButtons3.setTitle(quizArray[0][3] as? String, forState: .Normal)
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        if quizArray[0][4] as! Int == sender.tag {
            //正解数を増やす
            correctAnswer++
        }
        
        quizArray.removeAtIndex(0)
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            performSegueToResult()
        } else {
            choiceQuiz()
        }
    }
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toResultView") {
            
            let resultView = segue.destinationViewController as! ResultViewController
            resultView.correctAnswer = self.correctAnswer
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


