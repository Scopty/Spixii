var water : GameObject[];
var depthShader : Shader;

function Start()
{
	Camera.main.clearFlags = CameraClearFlags.Nothing;	
}

function OnPreCull()
{
	
	var planes : Plane[] = GeometryUtility.CalculateFrustumPlanes(Camera.main);
	
	GL.Clear(true, true, Camera.main.backgroundColor);
	for(var g : GameObject in water)
	{
		if(GeometryUtility.TestPlanesAABB(planes, g.renderer.bounds))
		{
			var bounds : Bounds = g.renderer.bounds;
			var corners : Vector3[] = new Vector3[4];
//			corners[0] = Camera.main. bounds.center + Vector3(bounds.extents.x, 0, bounds.extents.z);
//			corners[1] = bounds.center + Vector3(bounds.extents.x, 0, -bounds.extents.z);
//			corners[2] = bounds.center + Vector3(-bounds.extents.x, 0, bounds.extents.z);
//			corners[3] = bounds.center + Vector3(-bounds.extents.x, 0, -bounds.extents.z);			
		
			var reflectionCam : GameObject= new GameObject("reflectionCamera");
			reflectionCam.AddComponent(Camera);
			reflectionCam.camera.CopyFrom(Camera.main);
			reflectionCam.camera.enabled = false;
			var on : ObliqueNear = reflectionCam.AddComponent(ObliqueNear) as ObliqueNear;
			on.plane = g.transform;
			
			var mcp : Vector3 = Camera.main.transform.position;
			
			 reflectionCam.transform.position = Vector3(mcp.x, mcp.y - 2 * (mcp.y - g.transform.position.y), mcp.z);
			var plane : Plane = Plane(Vector3.up, bounds.center);
			
			var ray : Ray = Ray(Camera.main.transform.position, Camera.main.transform.forward);
			var dist : float;
			
			plane.Raycast(ray, dist);
			
			reflectionCam.transform.LookAt(Camera.main.transform.position + (Camera.main.transform.forward * dist));
			
			var flip : Matrix4x4;
			flip.SetTRS(Vector3.zero, Quaternion.identity, Vector3(1,-1,1));
			reflectionCam.camera.projectionMatrix *= flip;		
			reflectionCam.camera.cullingMask &= ~(1 << g.layer);
			GL.SetRevertBackfacing(true);			
			reflectionCam.camera.Render();
			GL.SetRevertBackfacing(false);	
			
			Destroy(reflectionCam);
			break;
		}
	}
	GL.Clear(true,false,Camera.main.backgroundColor);
	
	var depthCam : GameObject = new GameObject( "depthCam" );
	depthCam.AddComponent(Camera);
	depthCam.camera.CopyFrom(camera);
	depthCam.camera.cullingMask = 1 << water[0].layer;
	depthCam.camera.RenderWithShader(depthShader,"" );
	Destroy(depthCam);
}
