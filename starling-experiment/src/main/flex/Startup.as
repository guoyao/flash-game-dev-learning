package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import me.guoyao.WorldPlatform;
	
	import starling.core.Starling;

	[SWF(width = "960", height = "640", frameRate = "60", backgroundColor = "#002143")]
	public class Startup extends Sprite
	{
//		private var mStarling:Starling;
//
//		public function Startup()
//		{
//			// stats class for fps  
////			addChild(new Stats());
//			
//			stage.align = StageAlign.TOP_LEFT;
//			stage.scaleMode = StageScaleMode.NO_SCALE;
//			
//			mStarling = new Starling(Test, stage);
//			mStarling.simulateMultitouch = true;
//			mStarling.antiAliasing = 1;
////			mStarling.enableErrorChecking = true;
//			mStarling.start();
//		}
		
		private var _starling:Starling;
		public static var stage:Stage;
		
		public function Startup():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			Startup.stage = stage;
			
			// Initialize Starling
			_starling = new Starling(WorldPlatform, stage);
			_starling.start();
		}
	}
}
