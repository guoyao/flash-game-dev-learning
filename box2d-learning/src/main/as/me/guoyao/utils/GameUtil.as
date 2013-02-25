package me.guoyao.utils
{
	import flash.display.Sprite;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
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
		
		public static function floor(world:b2World):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(320), UnitUtil.pixelsToMeters(465));
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(UnitUtil.pixelsToMeters(320), UnitUtil.pixelsToMeters(15));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var theFloor:b2Body = world.CreateBody(bodyDef);
			theFloor.CreateFixture(fixtureDef);
		}
	}
}