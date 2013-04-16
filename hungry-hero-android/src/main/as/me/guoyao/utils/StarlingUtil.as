package me.guoyao.utils
{
	import flash.display.Stage;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;

	public class StarlingUtil
	{
		public static function scaleToFullScreen(starlingInstance:Starling, stage:Stage):void
		{
			starlingInstance.viewPort = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			starlingInstance.stage.stageWidth = stage.stageWidth;
			starlingInstance.stage.stageHeight = stage.stageHeight;
		}
	}
}