using UnityEngine;

public class Teleport : MonoBehaviour
{
   public Transform player;
    public Transform goal;

    private void OnTriggerEnter(Collider other)
    {
        player.position = goal.position;
    }
    private void OnCollisionEnter(Collision collision)
    {
        
    }
}
