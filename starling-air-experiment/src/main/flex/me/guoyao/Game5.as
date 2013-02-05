package me.guoyao
{
	import flash.text.Font;
	import flash.text.TextFieldType;

	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class Game5 extends Sprite
	{
		[Embed(source = '/../resources/assets/fonts/Abduction.ttf', embedAsCFF = 'false', fontName = 'Abduction')]
		public static var Abduction:Class;

		public function Game5()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		private function onAdded(e:Event):void
		{
			// create the font
			var font:Font = new Abduction();
			// create the TextField object
			var legend:TextField = new TextField(300, 300, "Here is some text, using an embedded font!", font.fontName, 38, 0xFFFFFF);
			legend.border = true;
			// centers the text on stage
			legend.x = stage.stageWidth - legend.width >> 1;
			legend.y = stage.stageHeight - legend.height >> 1;
			// create a Tween object
			var t:Tween = new Tween(legend, 4, Transitions.EASE_IN_OUT_BOUNCE);
			// move the object position
			t.moveTo(legend.x + 300, legend.y);
			// add it to the Juggler
			Starling.juggler.add(t);
			// listen to the start
			t.onStart = onStart;
			// listen to the progress
			t.onUpdate = onProgress;
			// listen to the end
			t.onComplete = onComplete;
			// show it
			addChild(legend);

			var textInput:flash.text.TextField = new flash.text.TextField();
			textInput.type = TextFieldType.INPUT;
			textInput.border = true;
			textInput.borderColor = 0xff0000;
			textInput.background = true;
			textInput.backgroundColor = 0xffffff;
			textInput.textColor = 0x000000;
			textInput.width = 150;
			textInput.height = 20;
			textInput.x = stage.stageWidth - textInput.width - 10;
			textInput.y = 10;
			Starling.current.nativeOverlay.addChild(textInput);
		}

		private function onStart():void
		{
			trace("tweening started");
		}

		private function onProgress():void
		{
			trace("tweening in progress");
		}

		private function onComplete():void
		{
			trace("tweening complete")
		}
	}
}
