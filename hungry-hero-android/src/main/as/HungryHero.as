/**
 *
 * Hungry Hero Game
 * http://www.hungryherogame.com
 * 
 * Copyright (c) 2012 Hemanth Sharma (www.hsharma.com). All rights reserved.
 * 
 * This ActionScript source code is free.
 * You can redistribute and/or modify it in accordance with the
 * terms of the accompanying Simplified BSD License Agreement.
 *  
 */

package
{
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	
	import me.guoyao.utils.StarlingUtil;
	
	import starling.core.Starling;
	
	/**
	 * SWF meta data defined for iPad 1 & 2 in landscape mode. 
	 */	
	[SWF(frameRate="60", width="1024", height="768", backgroundColor="0x000000")]
	
	/**
	 * @author hsharma
	 */
	public class HungryHero extends Sprite
	{
		private var myStarling:Starling;
		
		public function HungryHero()
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
			StarlingUtil.scaleToFullScreen(myStarling, stage);
			myStarling.antiAliasing = 1;
			myStarling.showStats = true;
			myStarling.showStatsAt("left", "bottom");
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