package me.guoyao.core
{
	import citrus.core.starling.StarlingState;
	
	import fr.kouma.starling.utils.Stats;
	
	public class StarlingState extends citrus.core.starling.StarlingState
	{
		public function StarlingState(engine:StarlingCitrusEngine = null)
		{
			super();
			_engine = engine;
		}
		
		private var _engine:StarlingCitrusEngine;
		
		override public function initialize():void
		{
			super.initialize();
			if(_engine)
			{
				if(_engine.showStats && !_engine.debugMode)
					addChild(new Stats());
				
				_engine = null;				
			}
		}
	}
}