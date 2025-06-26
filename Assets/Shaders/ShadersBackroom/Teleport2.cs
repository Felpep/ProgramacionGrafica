using UnityEngine;


public class Teleport2 : MonoBehaviour
{
    public GameObject player;
    public Transform goal;

    private void OnTriggerEnter(Collider other)
    {
        player.transform.position = goal.transform.position;
        Debug.Log("Entro");
    }

   
}

