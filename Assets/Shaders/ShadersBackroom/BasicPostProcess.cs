using UnityEngine;
using System.Collections;
using System.Collections.Generic;

[RequireComponent(typeof(Camera))]
public class BasicPostProcess : MonoBehaviour
{
    public Shader _shader;
    public Texture texture;
    [Range(0, 1)]
    [SerializeField] private float intensity;
    [SerializeField] private Color miColor;
    private float oldIntensity;
    private Color oldColor;

    private Material mat;

    void Start()
    {
        mat = new Material(_shader);
        mat.SetTexture("_Texture", texture);
        oldIntensity = intensity;
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 colorv3 = new Vector3(miColor.r, miColor.g, miColor.b);
        mat.SetVector("_ColorV3", colorv3);
        mat.SetColor("_MiHermosoColor", miColor);

        if (oldIntensity != intensity || oldColor != miColor)
            SetValues();
    }

    private void SetValues()
    {
        mat.SetFloat("_Intensity", intensity);
        oldIntensity = intensity;
        oldColor = miColor; 
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, mat);
    }
}
