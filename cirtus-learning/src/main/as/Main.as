package
{
	import citrus.core.starling.StarlingCitrusEngine;
	
	import starling.box2d.GameStage;
	
	[SWF(width="1024", height="768", frameRate="60", backgroundColor="#cccccc")]
	public class Main extends StarlingCitrusEngine
	{
		public function Main()
		{
			setUpStarling(true);
			state = new GameStage();
		}
	}
}