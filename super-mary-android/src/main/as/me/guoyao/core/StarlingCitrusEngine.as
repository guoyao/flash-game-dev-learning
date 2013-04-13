package me.guoyao.core
{
	import flash.geom.Rectangle;
	
	import citrus.core.starling.StarlingCitrusEngine;
	
	public class StarlingCitrusEngine extends citrus.core.starling.StarlingCitrusEngine
	{
		public function StarlingCitrusEngine(showStats:Boolean = false)
		{
			super();
			_showStats = showStats;
		}
		
		private var _showStats:Boolean;

		public function get showStats():Boolean
		{
			return _showStats;
		}
		
		private var _debugMode:Boolean;

		public function get debugMode():Boolean
		{
			return _debugMode;
		}

		override public function setUpStarling(debugMode:Boolean = false, antiAliasing:uint = 1, viewPort:Rectangle = null):void
		{
			_debugMode = debugMode;
			super.setUpStarling(debugMode, antiAliasing, viewPort);
		}
	}
}