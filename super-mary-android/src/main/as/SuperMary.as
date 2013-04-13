package
{
	import flash.geom.Rectangle;
	
	import me.guoyao.GameState;
	import me.guoyao.core.StarlingCitrusEngine;
	
	[SWF(frameRate="60")]
	public class SuperMary extends me.guoyao.core.StarlingCitrusEngine
	{
		public function SuperMary()
		{
			super(true);
			setUpStarling(false, 1, new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight));
//			this.starling.stage.stageWidth = (450 / 800) * stage.fullScreenWidth;
			this.starling.stage.stageHeight = 450;
			state = new GameState();
			trace(this.starling.contentScaleFactor);
		}
	}
}