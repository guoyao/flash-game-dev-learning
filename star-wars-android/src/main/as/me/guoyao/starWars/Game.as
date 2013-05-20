package me.guoyao.starWars
{
	import fr.kouma.starling.utils.Stats;
	
	import me.guoyao.starWars.screens.WelCome;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Game extends Sprite
	{
		private var welcome:WelCome;
		
		public function Game()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			initScreens();
			addChild(new Stats());
		}
		
		private function initScreens():void
		{
			welcome = new WelCome();
			addChild(welcome);
		}
	}
}