package
{
	import flash.display.Sprite;
	
	import me.guoyao.SiegeMachine;
	
	import net.hires.fps.Stats;

	[SWF(width = "640", height = "480", frameRate = "60", backgroundColor = "0x333333")]
	public class Main extends Sprite
	{
		public function Main() 
		{
			addChild(new Stats());
			addChild(new SiegeMachine());
		}
	}
}
