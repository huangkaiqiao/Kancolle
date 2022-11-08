using UnityEngine;
using UnityEngine.UI;
using System.Collections;
 
public class ShipSelectCreate : MonoBehaviour
{
 
    public GameObject Row_Prefab;//表头预设
 
    void Start()
    {
        for (int i = 0; i < 10; i++)//添加并修改预设的过程，将创建10行
        {
            //在Table下创建新的预设实例
            // GameObject table = GameObject.Find("Canvas/Panel/Table");
            GameObject table = GameObject.Find("MainCanvas/Org/Table");
            GameObject row = GameObject.Instantiate(Row_Prefab, table.transform.position, table.transform.rotation) as GameObject;
            row.name = "row" + (i + 1);
            row.transform.SetParent(table.transform);
            row.transform.localScale = Vector3.one;//设置缩放比例1,1,1，不然默认的比例非常大
            //设置预设实例中的各个子物体的文本内容
            row.transform.Find("TypeOfShip").GetComponent<Text>().text = "駆逐艦";
            row.transform.Find("ShipName").GetComponent<Text>().text = "吹雪";
            // row.transform.Find("Cell2").GetComponent<Text>().text = "class" + (i + 1);
        }
    }
 
}