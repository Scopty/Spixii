using UnityEngine;
using System.Collections;

public class ObjImportDemo : MonoBehaviour {
	
	public string filename;

	void Start () {
		OBJ obj = new OBJ();
		StartCoroutine(obj.Load(filename));
	}
	
	void Update () {
	}
}
