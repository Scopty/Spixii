using UnityEngine;
using System.Collections;

public class MoveCamera : MonoBehaviour {

public Vector3 beginPos;
public Vector3 endPos;
private GameObject[] c;
public bool animateState = false;
private int[] changed;
private string[] models = new string[4];
public int hitModel;
private bool mouseDown = false;

	// Use this for initialization
	void Start () {
		beginPos = new Vector3(0,0,-41);
		endPos = new Vector3(-4,-3.5f,-51);
		Camera.main.transform.position = beginPos;
		c = new GameObject[4];
		changed = new int[4];
		//if (exploring == true)
		//{
		for (int i=0; i < 4; i++) {
			models [i] = "Models_"+i;
			c[i] = GameObject.FindWithTag(models[i]);
			if(GameObject.FindWithTag(models[i])!=null&&i!=0)
			GameObject.FindWithTag(models[i]).SetActiveRecursively(false);
		
			/*foreach(GameObject c in GameObject.FindGameObjectsWithTag("Models_2"))
			{
				objArray.Push(c);
				c.active = false;
			}
		}*/
		}
		hitModel =0;
		
	}
	
	// Update is called once per frame
	void Update () {
		if (Camera.main.transform.position==endPos&&!mouseDown)
		{
		for (int xi = 0; xi < iPhoneInput.touchCount; xi++) {
			
			if (iPhoneInput.touchCount>xi&&iPhoneInput.touchCount<20&&iPhoneInput.GetTouch(xi)!=null)
			{
			//When touching set starttime to current time
			//float touchTime=Time.time;			
			
			//Get all touches
			iPhoneTouch touch = iPhoneInput.GetTouch(xi);
		//Where to touch hits the screen, raycast straight forward to check for hit on object.	
		Vector3 screenPosition = new Vector3(touch.position.x,touch.position.y,0.0f);
		//RaycastHit hit = new RaycastHit(); // need one of these to check for hits
		RaycastHit[] hits; 
		
		if (Physics.Raycast(Camera.main.ScreenPointToRay(screenPosition), Mathf.Infinity)&&animateState==false)
		{
			//print("hit");
			hits = Physics.RaycastAll(Camera.main.ScreenPointToRay(screenPosition), Mathf.Infinity);
			//RaycastHit hit = hits[0];
			//print(hits[0].transform.gameObject.name);*/
			
			for (int i=0; i<4;i++) {
				if (hits[0].transform.gameObject.name==models[i]) {beginPos = hits[0].transform.position+new Vector3(0,0,-4.5f);
				hitModel=i;}
			}
			//if (hit.transform.gameObject == gameObject)
		
			StartCoroutine(AnimateCamera(endPos, beginPos, hitModel));
				
				/*foreach(GameObject c in GameObject.FindGameObjectsWithTag("Models_2"))
				{
					objArray.Push(c);
					c.active = false;
				}*/
			
			//Camera.main.transform.Translate(5,5,10);
		}
	}
}
}
		if (Input.GetKeyDown(KeyCode.Y)&&animateState==false)
		{
			if (Camera.main.transform.position==beginPos) {
			StartCoroutine(AnimateCamera(beginPos, endPos, hitModel));
			
				/*while(objArray.length>0){
				GameObject  go = objArray.Pop();
				go.active = true;
			}*/
		}
		
		
		
		//if (!Input.GetMouseButton (0))
		//	return;

		// Only if we hit something, do we continue
		//RaycastHit hit;
		//if (!Physics.Raycast (camera.ScreenPointToRay(Input.mousePosition), hit))
		//	return;

		//Vector3 ray = camera.ScreenPointToRay (Input.mousePosition);
	
	}
	if(iPhoneInput.touchCount>0) mouseDown=true;
			else mouseDown=false;
	//print(hitModel);
}
	
	
	public IEnumerator AnimateCamera (Vector3 oldPos, Vector3 newPos, int currentObject) {

	//Vector3 newPos = new Vector3(aRay.origin.x, aRay.origin.y, transform.position.z);
	//Vector3 oldPos = transform.position;
	animateState=true;
	for (int i=0; i < 4; i++) {
		if (i!=currentObject&&c[i]!=null) {
			if (c[i].active == false) {c[i].SetActiveRecursively(true); changed[i]=1;}
		}
	}
	for (int l = 0; l <= 30f; l++) {
				float tLerpPct = l / 30f;
				transform.position = Vector3.Lerp(oldPos, newPos, tLerpPct);
				yield return new WaitForSeconds(0.000f);
			}
	for (int i=0; i < 4; i++) {
		if (i!=currentObject&&c[i]!=null) {
			if (c[i].active == true&&changed[i]==0) c[i].SetActiveRecursively(false);
			changed[i]=0;
		}
	}
	animateState=false;
}
}
