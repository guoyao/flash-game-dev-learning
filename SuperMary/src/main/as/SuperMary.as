package
{
	import me.guoyao.GameState;
	import me.guoyao.core.StarlingCitrusEngine;
	
	[SWF(frameRate="60")]
	public class SuperMary extends me.guoyao.core.StarlingCitrusEngine
	{
		public function SuperMary()
		{
			super(true);
			setUpStarling();
			state = new GameState(this);
		}
	}
}