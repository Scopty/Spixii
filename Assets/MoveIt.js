private var originalPos : Vector3;

function Start() {
	originalPos = transform.position;
}
//
function Update() {
	transform.position = originalPos + Vector3(1,0,0) * Mathf.Sin(Time.time) * 3.0;
}