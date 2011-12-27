using UnityEngine;
using System.Collections;
using System.IO;

//Last edited: 2010-12-29, clean up of code and commenting

public class Icons : MonoBehaviour {
	public Texture universeumLogo;
	public Texture biomniaLogo;
	public Texture btnTextureskin;
	public Texture btnTexturelungs;
	public Texture btnTextureskeleton;
	public GUISkin customskin;
	public GUISkin customskin2;
	private float timeLast;
	public string startText;
	private float m_fps;
	private float nextPrint;
	private float pressTime = 0; 

	
    void OnGUI() {
		GUI.skin = customskin2;
		Rect windowRect0 = new Rect(0, 0, Screen.width, Screen.height);
		for (int xi = 0; xi < iPhoneInput.touchCount; xi++) {
		if (iPhoneInput.touchCount>xi&&iPhoneInput.touchCount<20&&iPhoneInput.GetTouch(xi)!=null)
			{
			//When touching set starttime to current time
			//touchTime=Time.time;			
			
			//Get all touches
			iPhoneTouch touch = iPhoneInput.GetTouch(xi);
				
				Vector3 screenPosition = new Vector3(touch.position.x,touch.position.y,0.0f);
		// = new RaycastHit(); // need one of these to check for hits
		RaycastHit[] hits; 
		
		if (Physics.Raycast(Camera.main.ScreenPointToRay(screenPosition), Mathf.Infinity))
		{
			//print("hit");
			
			hits = Physics.RaycastAll(Camera.main.ScreenPointToRay(screenPosition), Mathf.Infinity);
			for (int ii=0; ii< hits.Length;ii++){
				if (hits[0].transform.gameObject.name=="hole") {
				hits[0].transform.gameObject.renderer.enabled=true;
				pressTime=Time.time;
				}
				}
			//	print(hits[ii].transform.gameObject.name);
			//if (hit.transform.gameObject == gameObject)
		}	
		}
	}
		//Set GUI style
		//if (Application.isEditor) {
		if (Time.time-pressTime<2&&Time.time>5) GUI.Box(windowRect0, "En skada i skelettet");
		else if (GameObject.Find("hole")!=null) GameObject.Find("hole").renderer.enabled=false;
	
			if (GUI.Button(new Rect(Screen.width/5*2f, Screen.height/12*0.50f,Screen.width/5*1f, Screen.height/12*1.2f), "Utgångsläge")){};
			GUI.Label(new Rect(Screen.width/5*2f, Screen.height/12*0.75f,Screen.width/5*1f, Screen.height/12*1.0f), "Tryck här för startvy!");
			if (GUI.Button(new Rect(Screen.width/5*3.8f, Screen.height/12*0.50f,Screen.width/5*1f, Screen.height/12*1.2f), "Fler modeller")){};
			GUI.Label(new Rect(Screen.width/5*3.8f, Screen.height/12*0.75f,Screen.width/5*1f, Screen.height/12*1.0f), "Välj en annan rekonstruktion!");
		//}
		GUI.skin = customskin;
		
		//Initialization text
		string startText2=startText;
		if (Time.time<3) {
			for (int i=0; i<Time.time;i++) startText2= startText2+".";
			GUI.Label(new Rect(0, 0,Screen.width, Screen.height), startText2);
		}
		
		//Display the universeum and biomnia logo
		GUI.Button(new Rect(Screen.width/30, Screen.height/30,Screen.width*1.2f*0.1432f, Screen.height*1.2f*0.0838f), universeumLogo);
		GUI.Button(new Rect((Screen.width/30)*23, Screen.height/12*10.5f, Screen.width*1.3f*0.1666f, Screen.height*1.3f*0.0837f), biomniaLogo);
		
		//Display the layer buttons
		GUI.Button(new Rect(Screen.width/5, Screen.height/12*9.5f,Screen.width/6, Screen.height/5), btnTextureskin);
		GUI.Button(new Rect((Screen.width/5)*2, Screen.height/12*9.5f, Screen.width/6, Screen.height/5), btnTexturelungs);
		GUI.Button(new Rect((Screen.width/5)*3, Screen.height/12*9.5f, Screen.width/6, Screen.height/5), btnTextureskeleton);
	
		if(Application.isEditor){
		if (Time.time>1+nextPrint) { nextPrint = Time.time; m_fps = Mathf.RoundToInt(1/Time.smoothDeltaTime);}
		GUI.Label(new Rect(0, 0, 100, 100), "FPS: "+m_fps);}
	}
}