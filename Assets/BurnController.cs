using UnityEngine;

public class BurnController : MonoBehaviour
{
    public Material mat;
    public GameObject go;
    //public Shader shader;
    //public MaterialPropertyBlock mat;
    //public Texture tex;
    private float burn = 0;
    public float burnSpeed;
    private float property;
    public bool active = false;

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
            if (property > 1)
            {
                print("hola");
                //go.SetActive(false);
            }
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        active = true;
    }
}
