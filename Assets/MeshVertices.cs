using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class MeshVertices : MonoBehaviour {

	public bool printVertices = false;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		if (!printVertices) {
			return;
		}
		Vector3[] vertices = GetComponent<MeshFilter> ().sharedMesh.vertices;
		foreach (Vector3 vertex in vertices) {
			print (vertex);
		}
		printVertices = false;
	}
}
