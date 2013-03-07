package
{
	import flash.display.Sprite;
	import flash.geom.Vector3D;

	public class Main extends Sprite
	{
		public function Main()
		{
			init();
		}

		private var putTheTreeHere:Vector3D = new Vector3D(50, 0, 5000);
		
		private var moveItByThisMuch:Vector3D = new Vector3D(50, 0, 0);

		private function init():void
		{
			moveTheTree();
		}
		
		private function moveTheTree():void
		{
			trace('The tree started here: ' + putTheTreeHere);
			putTheTreeHere = putTheTreeHere.add(moveItByThisMuch);
			trace('The tree is now here: ' + putTheTreeHere);
			putTheTreeHere.normalize();
			trace('The tree is now here: ' + putTheTreeHere);
		}
	}
}
