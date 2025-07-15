using UnityEngine;
using System.Collections;

public class Teleport : MonoBehaviour
{
   public Transform player;
    public Transform goal;

    private void OnTriggerEnter(Collider other)
    {
        SetPosition(player,goal);
    }

    public void SetPosition(Transform player, Transform goal)
    {
        player.position = goal.position;
        print("ppppp");
    }
}
