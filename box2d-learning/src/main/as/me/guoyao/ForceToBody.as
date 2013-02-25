package me.guoyao
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import me.guoyao.utils.GameUtil;
	import me.guoyao.utils.UnitUtil;

	public class ForceToBody extends Sprite
	{
		private var world:b2World;

		private var sphereVector:Vector.<b2Body>;

		public function ForceToBody()
		{
			world = new b2World(new b2Vec2(0, 10), true);
			GameUtil.debugDraw(this, world);
			GameUtil.floor(world);

			sphereVector = new Vector.<b2Body>();
			for (var i:int = 0; i < 3; i++)
			{
				sphereVector.push(sphere(170 + i * 150, 410, 40));
			}
			var force:b2Vec2 = new b2Vec2(0, -15);
			var forceByMass:b2Vec2 = force.Copy();
			forceByMass.Multiply(sphereVector[1].GetMass());
			var forceByMassByTime:b2Vec2 = forceByMass.Copy();
			forceByMassByTime.Multiply(60);
			var sphereCenter:b2Vec2 = sphereVector[0].GetWorldCenter();
			sphereVector[0].ApplyForce(forceByMassByTime, sphereCenter);
			sphereCenter = sphereVector[1].GetWorldCenter();
			sphereVector[1].ApplyImpulse(forceByMass, sphereCenter);
			sphereVector[2].SetLinearVelocity(force);
			addEventListener(Event.ENTER_FRAME, updateWorld);
		}

		private function sphere(pX:int, pY:int, r:Number):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY));
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = pY;
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

		private function updateWorld(e:Event):void
		{
			world.Step(1 / 60, 10, 10);

			var maxHeight:Number;
			var currHeight:Number;
			for (var i:int = 0; i < 3; i++)
			{
				maxHeight = sphereVector[i].GetUserData();
				currHeight = UnitUtil.metersToPixels(sphereVector[i].GetPosition().y);
				maxHeight = Math.min(maxHeight, currHeight);
				sphereVector[i].SetUserData(maxHeight);
				trace("Sphere " + i + ":" + Math.round(maxHeight));
			}
			trace("---------------");

			world.ClearForces();
			world.DrawDebugData();
		}
	}
}
