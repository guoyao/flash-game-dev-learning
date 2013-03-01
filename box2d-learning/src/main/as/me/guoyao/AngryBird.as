package me.guoyao
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import me.guoyao.support.AngryBirdContact;
	import me.guoyao.support.GameConstants;
	import me.guoyao.support.UserData;
	import me.guoyao.utils.GameUtil;
	import me.guoyao.utils.UnitUtil;

	public class AngryBird extends Sprite
	{
		private var world:b2World;

		private var theBird:Sprite = new Sprite();

		private var slingX:int = 100;

		private var slingY:int = 250;

		private var slingR:int = 75;

		public function AngryBird()
		{
			world = new b2World(new b2Vec2(0, 5), true);
			world.SetContactListener(new AngryBirdContact());
			GameUtil.debugDraw(this, world);
			GameUtil.ground(world);
			GameUtil.brick(world, 402, 431, 140, 36);
			GameUtil.brick(world, 544, 431, 140, 36);
			GameUtil.brick(world, 342, 396, 16, 32);
			GameUtil.brick(world, 604, 396, 16, 32);
			GameUtil.brick(world, 416, 347, 16, 130);
			GameUtil.brick(world, 532, 347, 16, 130);
			GameUtil.brick(world, 474, 273, 132, 16);
			GameUtil.brick(world, 474, 257, 32, 16);
			GameUtil.brick(world, 445, 199, 16, 130);
			GameUtil.brick(world, 503, 199, 16, 130);
			GameUtil.brick(world, 474, 125, 58, 16);
			GameUtil.brick(world, 474, 100, 32, 32);
			GameUtil.brick(world, 474, 67, 16, 32);
			GameUtil.brick(world, 474, 404, 64, 16);
			GameUtil.brick(world, 450, 363, 16, 64);
			GameUtil.brick(world, 498, 363, 16, 64);
			GameUtil.brick(world, 474, 322, 64, 16);
			pig(474, 232, 16);
			var slingCanvas:Sprite = new Sprite();
			slingCanvas.graphics.lineStyle(1, 0xffffff);
			slingCanvas.graphics.drawCircle(0, 0, slingR);
			addChild(slingCanvas);
			slingCanvas.x = slingX;
			slingCanvas.y = slingY;
			theBird.graphics.lineStyle(1, 0xfffffff);
			theBird.graphics.beginFill(0xffffff);
			theBird.graphics.drawCircle(0, 0, 15);
			addChild(theBird);
			theBird.x = slingX;
			theBird.y = slingY;
			theBird.addEventListener(MouseEvent.MOUSE_DOWN, birdClick);
			addEventListener(Event.ENTER_FRAME, updateWorld);
		}
		
		private function birdClick(e:MouseEvent):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, birdMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, birdRelease);
			theBird.removeEventListener(MouseEvent.MOUSE_DOWN, birdClick);
		}

		private function birdMove(e:MouseEvent):void
		{
			theBird.x = mouseX;
			theBird.y = mouseY;
			var distanceX:Number = theBird.x - slingX;
			var distanceY:Number = theBird.y - slingY;
			if (distanceX * distanceX + distanceY * distanceY > slingR * slingR)
			{
				var birdAngle:Number = Math.atan2(distanceY, distanceX);
				theBird.x = slingX + slingR * Math.cos(birdAngle);
				theBird.y = slingY + slingR * Math.sin(birdAngle);
			}
		}
		
		private function birdRelease(e:MouseEvent):void 
		{
			var distanceX:Number = theBird.x - slingX;
			var distanceY:Number = theBird.y - slingY;
			var velocityX:Number = -distanceX / 5;
			var velocityY:Number = -distanceY / 5;
			var birdVelocity:b2Vec2 = new b2Vec2(velocityX, velocityY);
			var sphereX:Number = UnitUtil.pixelsToMeters(theBird.x);
			var sphereY:Number = UnitUtil.pixelsToMeters(theBird.y);
			var r:Number = UnitUtil.pixelsToMeters(15);
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(sphereX, sphereY);
			bodyDef.type = b2Body.b2_dynamicBody;
			var circleShape:b2CircleShape = new b2CircleShape(r);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleShape;
			fixtureDef.density = 4;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var physicsBird:b2Body = world.CreateBody(bodyDef);
			physicsBird.CreateFixture(fixtureDef);
			physicsBird.SetLinearVelocity(birdVelocity);
			removeChild(theBird);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, birdMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, birdRelease);
		}

		private function pig(pX:int, pY:int, r:Number):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY));
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = new UserData(false, "pig");
			var pigShape:b2CircleShape = new b2CircleShape(UnitUtil.pixelsToMeters(r));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = pigShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var thePig:b2Body = world.CreateBody(bodyDef);
			thePig.CreateFixture(fixtureDef);
		}

		private function updateWorld(e:Event):void
		{
			world.Step(GameConstants.TIME_STEP, GameConstants.VELOCITY_ITERATIONS, GameConstants.POSITION_ITERATIONS);
			world.ClearForces();

			for (var body:b2Body = world.GetBodyList(); body; body = body.GetNext())
			{
				if (body.GetUserData() is UserData && (body.GetUserData() as UserData).breakable)
				{
					world.DestroyBody(body);
				}
			}
			
			world.DrawDebugData();
		}
	}
}
