using UnityEngine;
using System.Collections;

//Last edited: 2010-12-29, Clean up of code and commenting

public class SwitchModel : MonoBehaviour{
	
	public int[] state= new int[4];
	public int[] nothing= new int[4];
	float iSpeed = 2.0f;
	float iDelay = 0.01f;
	public Material skin_skal_full;
	public Material skin_eye_full;
	public Material skin_hud_full;
	public Material lung_full;
	public Material skeleton_full;
	public Material skin_transparent;
	public Material lung_transparent;
	
	public IEnumerator toggleLayer(Transform c, int i) {
		
		//Create a temporary Color variable for changing alpha channel
		Color tmp;
		tmp = c.renderer.sharedMaterial.color;
		
		//If alpha is less than 255, turn the alpha successively up to 255 (opaque)
		if(tmp.a<1.0f) {
			while(tmp.a<1.0f) {
				tmp.a += iSpeed*Time.smoothDeltaTime;
				if(tmp.a>1.0f) tmp.a=1.0f;
				c.renderer.sharedMaterial.color = tmp;
				//Wait for it to finish
				yield return new WaitForSeconds(iDelay);
				}
			//Wait for the Coroutine fullMaterial to finish
			yield return StartCoroutine(fullMaterial(c));
			}
			//If alpha is 255, turn the alpha successively down to 0 (transparent)
			else {
				//Wait for the Coroutine transparentMaterial to finish
				yield return StartCoroutine(transparentMaterial(c));
				tmp = c.renderer.sharedMaterial.color;
				while(tmp.a>0.0f) {
					tmp.a -= iSpeed*Time.smoothDeltaTime;
					if(tmp.a<0.0f) tmp.a=0.0f;
					c.renderer.sharedMaterial.color = tmp;
					//Wait for it to finish
					yield return new WaitForSeconds(iDelay);
				}
			}
			//Unlock state of change
			state[i]=0;
		}
		
	public IEnumerator justwait(int i) {
			yield return new WaitForSeconds(iDelay);
			state[i] =0;
		}
		
	//Switches object material to opaque
	public IEnumerator fullMaterial(Transform c) {
		c.renderer.sharedMaterial = (Material)Resources.Load("Materials/"+c.name, typeof(Material));
		foreach (Transform child2 in c) {
			child2.renderer.sharedMaterial = (Material)Resources.Load("Materials/"+c.name, typeof(Material));}
		/*if (c.name=="1_skin_skal") {
			c.renderer.sharedMaterial = skin_skal_full;
			foreach (Transform child in c) {child.renderer.sharedMaterial = skin_skal_full;}}
		if (c.name=="1_skin_hud") {
			c.renderer.sharedMaterial = skin_hud_full;
			foreach (Transform child in c) {child.renderer.sharedMaterial = skin_hud_full;}}
		if (c.name=="1_skin_eye") {
			c.renderer.sharedMaterial = skin_eye_full;
			foreach (Transform child in c) {child.renderer.sharedMaterial = skin_eye_full;}}
		if (c.name=="2_lungs") {
			c.renderer.sharedMaterial = lung_full;
			foreach (Transform child in c) {child.renderer.sharedMaterial = lung_full;}}*/
		//Wait until finished
		yield return new WaitForSeconds(iDelay);
		}
	
	//Switches object material to transparent
	public IEnumerator transparentMaterial(Transform c) {
		c.renderer.sharedMaterial = (Material)Resources.Load("Materials/"+(c.name).Substring(0,1)+"_transparent", typeof(Material));
		foreach (Transform child2 in c) {
			child2.renderer.sharedMaterial = (Material)Resources.Load("Materials/"+(c.name).Substring(0,1)+"_transparent", typeof(Material));}
		
		/*if (c.name=="1_skin_skal" || c.name=="1_skin_hud" || c.name=="1_skin_eye") {
			c.renderer.sharedMaterial = skin_transparent;
			foreach (Transform child in c) {child.renderer.sharedMaterial = skin_transparent;}}
		if (c.name=="2_lungs" || c.name=="2_lungs_trachea") {
			c.renderer.sharedMaterial = lung_transparent;
			foreach (Transform child in c) {child.renderer.sharedMaterial = lung_transparent;}}*/
		//Wait until finished
		yield return new WaitForSeconds(iDelay);
		}
}