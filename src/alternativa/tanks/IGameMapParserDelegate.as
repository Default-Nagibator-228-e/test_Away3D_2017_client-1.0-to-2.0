package alternativa.tanks
{
	import vos.RigidBodyVO;
	import vos.SceneObjectVO;
	import vos.SpawnPointVO;

	public interface IGameMapParserDelegate
	{
		function handleSpawnPoint(vo : SpawnPointVO) : void;
		function handleSceneObject(vo : SceneObjectVO) : void;
		function handleRigidBody(vo : RigidBodyVO) : void;
	}
}