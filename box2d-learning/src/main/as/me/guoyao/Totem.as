package me.guoyao
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
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
		
		private var textMon:TextField;
		
		public function Totem()
		{
			world = new b2World(new b2Vec2(0, 5), true);
			GameUtil.debugDraw(this, world);

			textMon = new TextField();
			textMon.x = 100;
			textMon.textColor = 0xffffff;
			textMon.width = 300;
			textMon.height = 300;
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 25;
			textMon.defaultTextFormat = textFormat;
			addChild(textMon);
			
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
			GameUtil.floor(world);
			
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

			for (var b:b2Body = world.GetBodyList(); b; b = b.GetNext())
			{
				if (b.GetUserData() && (b.GetUserData() as UserData).name == "idol")
				{
					var position:b2Vec2 = b.GetPosition();
					var xPos:Number = Math.round(UnitUtil.metersToPixels(position.x));
					textMon.text = xPos.toString();
					textMon.appendText(",");
					var yPos:Number = Math.round(UnitUtil.metersToPixels(position.y));
					textMon.appendText(yPos.toString());
					textMon.appendText("\nangle: ");
					var angle:Number = Math.round(UnitUtil.radToDeg(b.GetAngle()));
					textMon.appendText(angle.toString());
					textMon.appendText("\nVelocity: ");
					var velocity:b2Vec2 = b.GetLinearVelocity();
					var xVel:Number = Math.round(UnitUtil.metersToPixels(velocity.x));
					textMon.appendText(xVel.toString());
					textMon.appendText(",");
					var yVel:Number = Math.round(UnitUtil.metersToPixels(velocity.y));
					textMon.appendText(yVel.toString());
				}
			}
			
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
			bodyDef.userData = new UserData(false, "idol");
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
	}
}