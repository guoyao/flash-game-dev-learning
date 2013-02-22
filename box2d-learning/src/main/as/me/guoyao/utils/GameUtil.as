package me.guoyao.utils
{
	import flash.display.Sprite;
	
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2World;
	
	import me.guoyao.support.GameConstants;

	public class GameUtil
	{
		public static function debugDraw(container:Sprite, world:b2World):void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			container.addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(GameConstants.WORLD_SCALE);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit);
			debugDraw.SetFillAlpha(0.5);
			world.SetDebugDraw(debugDraw);
		}
	}
}