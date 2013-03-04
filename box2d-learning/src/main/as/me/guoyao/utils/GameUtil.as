package me.guoyao.utils
{
	import flash.display.Sprite;
	
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import me.guoyao.support.GameConstants;
	import me.guoyao.support.UserData;

	public class GameUtil
	{
		public static function debugDraw(container:Sprite, world:b2World):void
		{
			var debugDraw:b2DebugDraw = new b2DebugDraw();
			var debugSprite:Sprite = new Sprite();
			container.addChild(debugSprite);
			debugDraw.SetSprite(debugSprite);
			debugDraw.SetDrawScale(GameConstants.WORLD_SCALE);
			debugDraw.SetFlags(b2DebugDraw.e_shapeBit|b2DebugDraw.e_jointBit);
			debugDraw.SetFillAlpha(0.5);
			world.SetDebugDraw(debugDraw);
		}
		
		public static function brick(world:b2World, pX:int, pY:int, w:Number, h:Number, userData:* = null, container:Sprite = null):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY));
			bodyDef.type = b2Body.b2_dynamicBody;
			userData = userData ? userData : new UserData();
			if(userData is UserData)
			{
				(userData as UserData).name = "brick";
				if(container && (userData as UserData).asset)
					container.addChild((userData as UserData).asset);
			}
			bodyDef.userData = userData;
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(UnitUtil.pixelsToMeters(w / 2), UnitUtil.pixelsToMeters(h / 2));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 2;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var theBrick:b2Body = world.CreateBody(bodyDef);
			theBrick.CreateFixture(fixtureDef);
		}
		
		public static function sphere(world:b2World, pX:int, pY:int, r:Number, userData:* = null):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY));
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = userData;
			var circleShape:b2CircleShape = new b2CircleShape(UnitUtil.pixelsToMeters(r));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleShape;
			fixtureDef.density = 2;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var theSphere:b2Body = world.CreateBody(bodyDef);
			theSphere.CreateFixture(fixtureDef);
			return theSphere;
		}
		
		public static function ground(world:b2World, pX:int = 320, pY:int = 465, w:Number = 320, h:Number = 15):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY));
			bodyDef.userData = new UserData(false, GameConstants.GROUND);
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(UnitUtil.pixelsToMeters(w), UnitUtil.pixelsToMeters(h));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var theFloor:b2Body = world.CreateBody(bodyDef);
			theFloor.CreateFixture(fixtureDef);
		}
		
		public static function mouseToWorld(mouseX:Number, mouseY:Number):b2Vec2 
		{
			return new b2Vec2(UnitUtil.pixelsToMeters(mouseX), UnitUtil.pixelsToMeters(mouseY));
		}
	}
}