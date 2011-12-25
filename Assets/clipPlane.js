var clipPlane : Transform;
var clipPlaneMaterial : Material;
function Update () {
	clipPlaneMaterial.SetVector("_planePoint",clipPlane.position);
	clipPlaneMaterial.SetVector("_planeNormal",clipPlane.up);
}