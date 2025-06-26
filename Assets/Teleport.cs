using UnityEngine;
using System.Collections;

public class Teleport : MonoBehaviour
{
   public Transform player;
    public Transform goal;

    private void OnTriggerEnter(Collider other)
    {
        player.position = goal.position;
        Debug.Log("Entro");
    }
}
