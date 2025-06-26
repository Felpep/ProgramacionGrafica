using UnityEngine;
using System.Collections;

public class Teleport2 : MonoBehaviour
{
    public Transform player;
    public Transform goal;

    private void OnTriggerEnter(Collider other)
    {
        player.position = goal.transform.position;
        Debug.Log("Entro");
    }

   
}

