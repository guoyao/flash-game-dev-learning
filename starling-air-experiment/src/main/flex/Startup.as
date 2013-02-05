package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import me.guoyao.PhysicsTest;
	
	import net.hires.fps.Stats;
	
	import starling.core.Starling;
	
	[SWF(width = "960", height = "640", frameRate = "60", backgroundColor = "#002143")]
	public class Startup extends Sprite
	{
		private var mStarling:Starling;
		
		public function Startup()
		{
			// stats class for fps  
			addChild(new Stats());
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// create our Starling instance 
			mStarling = new Starling(PhysicsTest, stage);
			
			// emulate multi-touch
			mStarling.simulateMultitouch = true;
			
			// set anti-aliasing (higher the better quality but slower performance) 
			mStarling.antiAliasing = 1;
			
			//			mStarling.enableErrorChecking = true;
			
			// start it! 
			mStarling.start();
		}
	}
}
