using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BasicCameraMovement : MonoBehaviour {

	[SerializeField]
	private float moveSpeed = 5;

	[SerializeField]
	private float scrollSpeed = 5;

	private float scrollOffset = 10;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		float horiMovement = Input.GetAxis ("Horizontal") * -1; //Cuz the camera is reversed
		float vertMovement = Input.GetAxis ("Vertical");
		float scrollMovement = -Input.GetAxis ("Mouse ScrollWheel") * scrollOffset;
		Vector3 movementVector = new Vector3 (horiMovement, vertMovement, 0) * moveSpeed;

		transform.position += movementVector * Time.deltaTime;
		GetComponent<Camera> ().fieldOfView += scrollMovement * scrollSpeed;
		GetComponent<Camera> ().fieldOfView = Mathf.Clamp(GetComponent<Camera>().fieldOfView, 10, 175);
	}
}
