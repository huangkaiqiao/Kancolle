using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GUITest : MonoBehaviour
{
    void OnGui ()
    {
        // 创建背景框
        GUI.Box(new Rect(10,10,100,90), "Loader Menu");
    
        // 创建第一个按钮。如果按下此按钮，则会执行 Application.Loadlevel (1)
        if(GUI.Button(new Rect(20,40,80,20), "Level 1"))
        {
            Application.LoadLevel(1);
        }
    
        // 创建第二个按钮。
        if(GUI.Button(new Rect(20,70,80,20),"Level 2")) 
        {
            Application.LoadLevel(2);
        }
    }
}
