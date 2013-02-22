package me.guoyao
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import me.guoyao.support.UserData;
	import me.guoyao.utils.GameUtil;
	import me.guoyao.utils.UnitUtil;
	
	public class Totem extends Sprite
	{
		private var world:b2World;
		
		public function Totem()
		{
			world = new b2World(new b2Vec2(0, 5), true);
			GameUtil.debugDraw(this, world);
			
			var breakableBrickUserData:UserData = new UserData();
			var unbreakableBrickUserData:UserData = new UserData(false);

			brick(275, 435, 30, 30, breakableBrickUserData);
			brick(365, 435, 30, 30, breakableBrickUserData);
			brick(320, 405, 120, 30, breakableBrickUserData);
			brick(320, 375, 60, 30, unbreakableBrickUserData);
			brick(305, 345, 90, 30, breakableBrickUserData);
			brick(320, 300, 120, 60, unbreakableBrickUserData);
//			brick(320, 255, 240, 30);
//			brick(215, 210, 30, 60);
			
			idol(320, 242);
			floor();
			
			addEventListener(Event.ENTER_FRAME, updateWorld);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			stage.addEventListener(MouseEvent.CLICK, destroyBrick);
		}
		
		private function updateWorld(e:Event):void
		{
			var timeStep:Number = 1 / 60;
			var velIterations:int = 10;
			var posIterations:int = 10;
			world.Step(timeStep, velIterations, posIterations);
			world.ClearForces();
			world.DrawDebugData();
		}

		private function destroyBrick(e:MouseEvent):void
		{
			var pX:Number = UnitUtil.pixelsToMeters(mouseX);
			var pY:Number = UnitUtil.pixelsToMeters(mouseY);
			world.QueryPoint(queryCallback, new b2Vec2(pX, pY));
		}

		private function queryCallback(fixture:b2Fixture):Boolean
		{
			var touchedBody:b2Body = fixture.GetBody();
			if(touchedBody.GetUserData() is UserData && (touchedBody.GetUserData() as UserData).breakable)
			{
				world.DestroyBody(touchedBody);
			}
			return false;
		}
		
		private function brick(pX:int, pY:int, w:Number, h:Number, userData:UserData = null):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY));
		 	bodyDef.type = b2Body.b2_dynamicBody;
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

		private function idol(pX:Number, pY:Number):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY));
			bodyDef.type = b2Body.b2_dynamicBody;
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(UnitUtil.pixelsToMeters(5), UnitUtil.pixelsToMeters(20));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var theIdol:b2Body = world.CreateBody(bodyDef);
			theIdol.CreateFixture(fixtureDef);
			var bW:Number = UnitUtil.pixelsToMeters(5);
			var bH:Number = UnitUtil.pixelsToMeters(20);
			var boxPos:b2Vec2 = new b2Vec2(0, UnitUtil.pixelsToMeters(10));
			var boxAngle:Number = -Math.PI / 4;
			polygonShape.SetAsOrientedBox(bW, bH, boxPos, boxAngle);
			fixtureDef.shape = polygonShape;
			theIdol.CreateFixture(fixtureDef);
			boxAngle = Math.PI / 4;
			polygonShape.SetAsOrientedBox(bW, bH, boxPos, boxAngle);
			fixtureDef.shape = polygonShape;
			theIdol.CreateFixture(fixtureDef);
			var vertices:Vector.<b2Vec2> = new Vector.<b2Vec2>();
			vertices.push(new b2Vec2(UnitUtil.pixelsToMeters(-15), UnitUtil.pixelsToMeters(-25)));
			vertices.push(new b2Vec2(0, UnitUtil.pixelsToMeters(-40)));
			vertices.push(new b2Vec2(UnitUtil.pixelsToMeters(15), UnitUtil.pixelsToMeters(-25)));
			vertices.push(new b2Vec2(0, UnitUtil.pixelsToMeters(-10)));
			polygonShape.SetAsVector(vertices, vertices.length);
			fixtureDef.shape = polygonShape;
			theIdol.CreateFixture(fixtureDef);
		}

		private function floor():void
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