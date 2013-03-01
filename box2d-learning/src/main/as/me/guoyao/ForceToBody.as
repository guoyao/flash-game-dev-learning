package me.guoyao
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	
	import me.guoyao.support.GameConstants;
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
			GameUtil.ground(world);

			sphereVector = new Vector.<b2Body>();
			for (var i:int = 0; i < 3; i++)
			{
				sphereVector.push(GameUtil.sphere(world, 170 + i * 150, 410, 40, 410));
			}
			var force:b2Vec2 = new b2Vec2(0, -15);
			var forceByMass:b2Vec2 = force.Copy();
			forceByMass.Multiply(sphereVector[1].GetMass());
			var forceByMassByTime:b2Vec2 = forceByMass.Copy();
			forceByMassByTime.Multiply(GameConstants.FPS);
			var sphereCenter:b2Vec2 = sphereVector[0].GetWorldCenter();
			sphereVector[0].ApplyForce(forceByMassByTime, sphereCenter);
			sphereCenter = sphereVector[1].GetWorldCenter();
			sphereVector[1].ApplyImpulse(forceByMass, sphereCenter);
			sphereVector[2].SetLinearVelocity(force);
			addEventListener(Event.ENTER_FRAME, updateWorld);
		}

		private function updateWorld(e:Event):void
		{
			world.Step(GameConstants.TIME_STEP, GameConstants.VELOCITY_ITERATIONS, GameConstants.POSITION_ITERATIONS);

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
