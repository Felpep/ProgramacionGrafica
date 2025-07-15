using UnityEngine;

public class BurnController : MonoBehaviour
{
    [SerializeField] private Teleport2 teleport;

    public Material mat;
    public GameObject go;
    private float burn = 0;
    public float burnSpeed;
    private float property;
    public bool active = false;
    public Transform goal;
    public GameObject player;


    private void Start()
    {
        property = Shader.PropertyToID("_Burn");
        mat.SetFloat("_Burn", 0);

    }
    private void Update()
    {
        if (active)
        {
            mat.SetFloat("_Burn", burn += burnSpeed);
            if (burn >= 0.6f && burn <= 0.62f)
            {
                teleport.SetPosition(player,goal);
            }

        }

    }

    private void OnTriggerEnter(Collider other)
    {
        active = true;
    }
}
