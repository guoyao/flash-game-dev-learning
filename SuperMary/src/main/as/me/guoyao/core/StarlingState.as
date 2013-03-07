package me.guoyao.core
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	
	import fr.kouma.starling.utils.Stats;
	
	public class StarlingState extends citrus.core.starling.StarlingState
	{
		public function StarlingState()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var engine:CitrusEngine = CitrusEngine.getInstance();
			if(engine is StarlingCitrusEngine && StarlingCitrusEngine(engine).showStats && !StarlingCitrusEngine(engine).debugMode)
				addChild(new Stats());
		}
	}
}