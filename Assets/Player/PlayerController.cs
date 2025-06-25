using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    private CharacterController player;
    private Vector3 axis, movePlayer;

    [SerializeField] private Transform cameraTransform;

    [Header("PARAMETERS")]
    public float moveSpeed;
    public float gravity;
    public float fallVelocity;
    public float jumpForce;
    [Min(1)]
    public float speedMultiplier;

    private void Awake()
    {
        player = GetComponent<CharacterController>();
    }

    private void Update()
    {
        axis = new Vector3(Input.GetAxis("Horizontal"), 0, Input.GetAxis("Vertical"));

        if (axis.magnitude > 1)
            axis = cameraTransform.TransformDirection(axis.normalized);
        else
            axis = cameraTransform.TransformDirection(axis);

        axis.y = 0;

        movePlayer.x = axis.x;
        movePlayer.z = axis.z;

        SetGravity();

        if (Input.GetKey(KeyCode.LeftShift))
        {
            player.Move(movePlayer * speedMultiplier * Time.deltaTime);
        }
        else
        {
            player.Move(movePlayer * moveSpeed * Time.deltaTime);
        }
    }

    private void SetGravity()
    {
        if (player.isGrounded)
        {
            fallVelocity = -gravity * Time.deltaTime;
            if (Input.GetKey(KeyCode.Space)) fallVelocity = jumpForce;
        }
        else
        {
            fallVelocity -= gravity * Time.deltaTime;
        }

        movePlayer.y = fallVelocity;
    }
}
