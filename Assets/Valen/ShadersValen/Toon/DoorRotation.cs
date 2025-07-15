using UnityEngine;
using static UnityEngine.GraphicsBuffer;

public class DoorRotation : MonoBehaviour
{
    [SerializeField] private Transform player;
    
    private void Update()
    {
        if (player != null)
        {
            //transform.LookAt(player);

            Vector3 lookPos = player.position - transform.position;
            lookPos.y = 0; // Eliminar inclinación vertical
            if (lookPos.sqrMagnitude > 0.001f)
            {
                transform.rotation = Quaternion.LookRotation(lookPos);
            }
        }
    }
}
