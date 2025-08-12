using UnityEngine;

namespace LowPolyDungeonsLite.MySHader
{
    public class PointerFollower : MonoBehaviour
    {
        [SerializeField, Range(0f, 100f)] private float distanceToCamera = 1;
        
        public Camera _camera;

        private void Awake() => 
            _camera = Camera.main;

        private void Update()
        {
            Vector3 pos = Input.mousePosition;
            pos.z = distanceToCamera;
            transform.position = _camera.ScreenToWorldPoint(pos);
        }
    }
}
