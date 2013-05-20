package
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	
	import me.guoyao.starWars.Game;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="480", height="800", backgroundColor="0x000000")]
	public class StarWars extends Sprite
	{
		private var myStarling:Starling;
		
		public function StarWars()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			if(Capabilities.cpuArchitecture == "ARM")
			{
				NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onActivate);
				NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onDeactivate)
				NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
		}
		
		protected function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			myStarling = new Starling(Game, stage);
			myStarling.viewPort = new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			myStarling.antiAliasing = 1;
			myStarling.showStats = true;
			myStarling.showStatsAt("right", "top");
			myStarling.start();
		}
		
		private function onActivate(event:Event):void
		{
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
		}
		
		private function onDeactivate(event:Event):void
		{
			exit();
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.BACK)
				exit();
		}
		
		private function exit():void
		{
			NativeApplication.nativeApplication.removeEventListener(Event.ACTIVATE, onActivate);
			NativeApplication.nativeApplication.removeEventListener(Event.DEACTIVATE, onDeactivate)
			NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			NativeApplication.nativeApplication.exit();
		}
	}
}