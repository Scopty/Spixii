var depthShader : Shader;

function Awake()
{
	if(Camera.main.GetComponent(RenderWater))
	{
		var renderWater : RenderWater = (Camera.main.gameObject.GetComponent(RenderWater) as RenderWater);
		var temp : GameObject[]  = renderWater.water;
		(Camera.main.gameObject.GetComponent(RenderWater) as RenderWater).water = new GameObject[renderWater.water.Length +1];
		System.Array.Copy(temp,(Camera.main.gameObject.GetComponent(RenderWater) as RenderWater).water,temp.Length);
		(Camera.main.gameObject.GetComponent(RenderWater) as RenderWater).water[temp.Length] = gameObject;
	}
	else
	{
		var newWater : RenderWater = Camera.main.gameObject.AddComponent(RenderWater) as RenderWater;
		(Camera.main.gameObject.GetComponent(RenderWater) as RenderWater).depthShader = depthShader;
		(Camera.main.gameObject.GetComponent(RenderWater) as RenderWater).water = new GameObject[1];
		(Camera.main.gameObject.GetComponent(RenderWater) as RenderWater).water[0] = gameObject;
	}
	
	Destroy( this );
}