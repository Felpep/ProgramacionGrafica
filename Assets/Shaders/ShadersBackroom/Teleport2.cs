using UnityEngine;


public class Teleport2 : MonoBehaviour
{
    public GameObject player;
    public Transform goal;

    private void OnTriggerEnter(Collider other)
    {
        SetPosition(player,goal);
    }
    public void SetPosition(GameObject player, Transform goal)
    {
        player.transform.position = goal.position;
        //print("QQQQQQQQQQQQQQQQQ");
    }

}

