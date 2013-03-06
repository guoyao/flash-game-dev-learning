package me.guoyao.objects
{
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	
	import citrus.objects.Box2DPhysicsObject;

	/**
	 * @author Aymeric
	 * <p>This is a class created by the software http://www.physicseditor.de/</p>
	 * <p>Just select the CitrusEngine template, upload your png picture, set polygons and export.</p>
	 * <p>Be careful, the registration point is topLeft !</p>
	 * @param peObject : the name of the png file
	 */
	public class PhysicsEditorObjects extends Box2DPhysicsObject
	{

		[Inspectable(defaultValue = "")]
		public var peObject:String = "";

		private var _tab:Array;

		public function PhysicsEditorObjects(name:String, params:Object = null)
		{
			super(name, params);
		}

		override public function destroy():void
		{
			super.destroy();
		}

		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}

		override protected function defineFixture():void
		{
			super.defineFixture();

			_createVertices();

			_fixtureDef.density = _getDensity();
			_fixtureDef.friction = _getFriction();
			_fixtureDef.restitution = _getRestitution();

			for (var i:uint = 0; i < _tab.length; ++i)
			{
				var polygonShape:b2PolygonShape = new b2PolygonShape();
				polygonShape.Set(_tab[i]);
				_fixtureDef.shape = polygonShape;

				body.CreateFixture(_fixtureDef);
			}
		}

		protected function _createVertices():void
		{
			_tab = [];
			var vertices:Vector.<b2Vec2> = new Vector.<b2Vec2>();

			switch (peObject)
			{
				case "icecream":
					vertices.push(new b2Vec2(37 / _box2D.scale, 14 / _box2D.scale));
					vertices.push(new b2Vec2(25 / _box2D.scale, 10 / _box2D.scale));
					vertices.push(new b2Vec2(38 / _box2D.scale, 10 / _box2D.scale));
					vertices.push(new b2Vec2(39 / _box2D.scale, 13 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(2 / _box2D.scale, 40 / _box2D.scale));
					vertices.push(new b2Vec2(4 / _box2D.scale, 38 / _box2D.scale));
					vertices.push(new b2Vec2(7 / _box2D.scale, 49 / _box2D.scale));
					vertices.push(new b2Vec2(2 / _box2D.scale, 48 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(20 / _box2D.scale, 112 / _box2D.scale));
					vertices.push(new b2Vec2(20 / _box2D.scale, 105 / _box2D.scale));
					vertices.push(new b2Vec2(37 / _box2D.scale, 63 / _box2D.scale));
					vertices.push(new b2Vec2(27 / _box2D.scale, 114 / _box2D.scale));
					vertices.push(new b2Vec2(22 / _box2D.scale, 115 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(11 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(13 / _box2D.scale, 63 / _box2D.scale));
					vertices.push(new b2Vec2(11 / _box2D.scale, 62 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(6 / _box2D.scale, 23 / _box2D.scale));
					vertices.push(new b2Vec2(8 / _box2D.scale, 23 / _box2D.scale));
					vertices.push(new b2Vec2(13 / _box2D.scale, 63 / _box2D.scale));
					vertices.push(new b2Vec2(11 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(7 / _box2D.scale, 49 / _box2D.scale));
					vertices.push(new b2Vec2(2 / _box2D.scale, 30 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(14 / _box2D.scale, 20 / _box2D.scale));
					vertices.push(new b2Vec2(37 / _box2D.scale, 22 / _box2D.scale));
					vertices.push(new b2Vec2(42 / _box2D.scale, 51 / _box2D.scale));
					vertices.push(new b2Vec2(40 / _box2D.scale, 57 / _box2D.scale));
					vertices.push(new b2Vec2(37 / _box2D.scale, 63 / _box2D.scale));
					vertices.push(new b2Vec2(8 / _box2D.scale, 23 / _box2D.scale));
					vertices.push(new b2Vec2(11 / _box2D.scale, 20 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(36 / _box2D.scale, 19 / _box2D.scale));
					vertices.push(new b2Vec2(14 / _box2D.scale, 20 / _box2D.scale));
					vertices.push(new b2Vec2(20 / _box2D.scale, 12 / _box2D.scale));
					vertices.push(new b2Vec2(25 / _box2D.scale, 10 / _box2D.scale));
					vertices.push(new b2Vec2(37 / _box2D.scale, 14 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(43 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(37 / _box2D.scale, 22 / _box2D.scale));
					vertices.push(new b2Vec2(44 / _box2D.scale, 28 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(40 / _box2D.scale, 57 / _box2D.scale));
					vertices.push(new b2Vec2(42 / _box2D.scale, 51 / _box2D.scale));
					vertices.push(new b2Vec2(42 / _box2D.scale, 56 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(7 / _box2D.scale, 49 / _box2D.scale));
					vertices.push(new b2Vec2(11 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 53 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(47 / _box2D.scale, 47 / _box2D.scale));
					vertices.push(new b2Vec2(44 / _box2D.scale, 51 / _box2D.scale));
					vertices.push(new b2Vec2(42 / _box2D.scale, 51 / _box2D.scale));
					vertices.push(new b2Vec2(43 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(47 / _box2D.scale, 38 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(42 / _box2D.scale, 51 / _box2D.scale));
					vertices.push(new b2Vec2(37 / _box2D.scale, 22 / _box2D.scale));
					vertices.push(new b2Vec2(43 / _box2D.scale, 32 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(37 / _box2D.scale, 22 / _box2D.scale));
					vertices.push(new b2Vec2(14 / _box2D.scale, 20 / _box2D.scale));
					vertices.push(new b2Vec2(36 / _box2D.scale, 19 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(20 / _box2D.scale, 105 / _box2D.scale));
					vertices.push(new b2Vec2(18 / _box2D.scale, 101 / _box2D.scale));
					vertices.push(new b2Vec2(8 / _box2D.scale, 23 / _box2D.scale));
					vertices.push(new b2Vec2(37 / _box2D.scale, 63 / _box2D.scale));

					_tab.push(vertices);

					break;
				case "hamburger":
					vertices.push(new b2Vec2(97 / _box2D.scale, 55 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 35 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(100 / _box2D.scale, 52 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(6 / _box2D.scale, 35 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 37 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(58 / _box2D.scale, 7 / _box2D.scale));
					vertices.push(new b2Vec2(66 / _box2D.scale, 5 / _box2D.scale));
					vertices.push(new b2Vec2(78 / _box2D.scale, 6 / _box2D.scale));
					vertices.push(new b2Vec2(89 / _box2D.scale, 10 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 16 / _box2D.scale));
					vertices.push(new b2Vec2(100 / _box2D.scale, 25 / _box2D.scale));
					vertices.push(new b2Vec2(98 / _box2D.scale, 31 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(77 / _box2D.scale, 71 / _box2D.scale));
					vertices.push(new b2Vec2(39 / _box2D.scale, 71 / _box2D.scale));
					vertices.push(new b2Vec2(17 / _box2D.scale, 68 / _box2D.scale));
					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(97 / _box2D.scale, 55 / _box2D.scale));
					vertices.push(new b2Vec2(95 / _box2D.scale, 67 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(6 / _box2D.scale, 54 / _box2D.scale));
					vertices.push(new b2Vec2(10 / _box2D.scale, 51 / _box2D.scale));
					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(8 / _box2D.scale, 58 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 56 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(98 / _box2D.scale, 47 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(93 / _box2D.scale, 38 / _box2D.scale));
					vertices.push(new b2Vec2(95 / _box2D.scale, 38 / _box2D.scale));
					vertices.push(new b2Vec2(98 / _box2D.scale, 41 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(7 / _box2D.scale, 41 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(10 / _box2D.scale, 51 / _box2D.scale));
					vertices.push(new b2Vec2(7 / _box2D.scale, 48 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(14 / _box2D.scale, 15 / _box2D.scale));
					vertices.push(new b2Vec2(29 / _box2D.scale, 8 / _box2D.scale));
					vertices.push(new b2Vec2(40 / _box2D.scale, 6 / _box2D.scale));
					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 35 / _box2D.scale));
					vertices.push(new b2Vec2(4 / _box2D.scale, 34 / _box2D.scale));
					vertices.push(new b2Vec2(7 / _box2D.scale, 23 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(40 / _box2D.scale, 6 / _box2D.scale));
					vertices.push(new b2Vec2(58 / _box2D.scale, 7 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(17 / _box2D.scale, 68 / _box2D.scale));
					vertices.push(new b2Vec2(15 / _box2D.scale, 66 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(10 / _box2D.scale, 51 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(93 / _box2D.scale, 38 / _box2D.scale));

					_tab.push(vertices);

					vertices.push(new b2Vec2(97 / _box2D.scale, 55 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 35 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(100 / _box2D.scale, 52 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(6 / _box2D.scale, 35 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 37 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(58 / _box2D.scale, 7 / _box2D.scale));
					vertices.push(new b2Vec2(66 / _box2D.scale, 5 / _box2D.scale));
					vertices.push(new b2Vec2(78 / _box2D.scale, 6 / _box2D.scale));
					vertices.push(new b2Vec2(89 / _box2D.scale, 10 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 16 / _box2D.scale));
					vertices.push(new b2Vec2(100 / _box2D.scale, 25 / _box2D.scale));
					vertices.push(new b2Vec2(98 / _box2D.scale, 31 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(77 / _box2D.scale, 71 / _box2D.scale));
					vertices.push(new b2Vec2(39 / _box2D.scale, 71 / _box2D.scale));
					vertices.push(new b2Vec2(17 / _box2D.scale, 68 / _box2D.scale));
					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(97 / _box2D.scale, 55 / _box2D.scale));
					vertices.push(new b2Vec2(95 / _box2D.scale, 67 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(6 / _box2D.scale, 54 / _box2D.scale));
					vertices.push(new b2Vec2(10 / _box2D.scale, 51 / _box2D.scale));
					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(8 / _box2D.scale, 58 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 56 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(98 / _box2D.scale, 47 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(93 / _box2D.scale, 38 / _box2D.scale));
					vertices.push(new b2Vec2(95 / _box2D.scale, 38 / _box2D.scale));
					vertices.push(new b2Vec2(98 / _box2D.scale, 41 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(7 / _box2D.scale, 41 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(10 / _box2D.scale, 51 / _box2D.scale));
					vertices.push(new b2Vec2(7 / _box2D.scale, 48 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(14 / _box2D.scale, 15 / _box2D.scale));
					vertices.push(new b2Vec2(29 / _box2D.scale, 8 / _box2D.scale));
					vertices.push(new b2Vec2(40 / _box2D.scale, 6 / _box2D.scale));
					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 35 / _box2D.scale));
					vertices.push(new b2Vec2(4 / _box2D.scale, 34 / _box2D.scale));
					vertices.push(new b2Vec2(7 / _box2D.scale, 23 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(40 / _box2D.scale, 6 / _box2D.scale));
					vertices.push(new b2Vec2(58 / _box2D.scale, 7 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(17 / _box2D.scale, 68 / _box2D.scale));
					vertices.push(new b2Vec2(15 / _box2D.scale, 66 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(10 / _box2D.scale, 51 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(93 / _box2D.scale, 38 / _box2D.scale));

					_tab.push(vertices);

					vertices.push(new b2Vec2(97 / _box2D.scale, 55 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 35 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(100 / _box2D.scale, 52 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(6 / _box2D.scale, 35 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 37 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(58 / _box2D.scale, 7 / _box2D.scale));
					vertices.push(new b2Vec2(66 / _box2D.scale, 5 / _box2D.scale));
					vertices.push(new b2Vec2(78 / _box2D.scale, 6 / _box2D.scale));
					vertices.push(new b2Vec2(89 / _box2D.scale, 10 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 16 / _box2D.scale));
					vertices.push(new b2Vec2(100 / _box2D.scale, 25 / _box2D.scale));
					vertices.push(new b2Vec2(98 / _box2D.scale, 31 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(77 / _box2D.scale, 71 / _box2D.scale));
					vertices.push(new b2Vec2(39 / _box2D.scale, 71 / _box2D.scale));
					vertices.push(new b2Vec2(17 / _box2D.scale, 68 / _box2D.scale));
					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(97 / _box2D.scale, 55 / _box2D.scale));
					vertices.push(new b2Vec2(95 / _box2D.scale, 67 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(6 / _box2D.scale, 54 / _box2D.scale));
					vertices.push(new b2Vec2(10 / _box2D.scale, 51 / _box2D.scale));
					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(8 / _box2D.scale, 58 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 56 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(98 / _box2D.scale, 47 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(93 / _box2D.scale, 38 / _box2D.scale));
					vertices.push(new b2Vec2(95 / _box2D.scale, 38 / _box2D.scale));
					vertices.push(new b2Vec2(98 / _box2D.scale, 41 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(7 / _box2D.scale, 41 / _box2D.scale));
					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(10 / _box2D.scale, 51 / _box2D.scale));
					vertices.push(new b2Vec2(7 / _box2D.scale, 48 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(14 / _box2D.scale, 15 / _box2D.scale));
					vertices.push(new b2Vec2(29 / _box2D.scale, 8 / _box2D.scale));
					vertices.push(new b2Vec2(40 / _box2D.scale, 6 / _box2D.scale));
					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(6 / _box2D.scale, 35 / _box2D.scale));
					vertices.push(new b2Vec2(4 / _box2D.scale, 34 / _box2D.scale));
					vertices.push(new b2Vec2(7 / _box2D.scale, 23 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(40 / _box2D.scale, 6 / _box2D.scale));
					vertices.push(new b2Vec2(58 / _box2D.scale, 7 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(17 / _box2D.scale, 68 / _box2D.scale));
					vertices.push(new b2Vec2(15 / _box2D.scale, 66 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(9 / _box2D.scale, 37 / _box2D.scale));
					vertices.push(new b2Vec2(14 / _box2D.scale, 59 / _box2D.scale));
					vertices.push(new b2Vec2(10 / _box2D.scale, 51 / _box2D.scale));

					_tab.push(vertices);
					vertices = new Vector.<b2Vec2>();

					vertices.push(new b2Vec2(96 / _box2D.scale, 50 / _box2D.scale));
					vertices.push(new b2Vec2(90 / _box2D.scale, 32 / _box2D.scale));
					vertices.push(new b2Vec2(93 / _box2D.scale, 38 / _box2D.scale));

					_tab.push(vertices);

					break;
			}
		}

		protected function _getDensity():Number
		{
			switch (peObject)
			{
				case "icecream":
					return 1;
					break;
				case "hamburger":
					return 1;
					break;
			}
			return 1;
		}

		protected function _getFriction():Number
		{
			switch (peObject)
			{
				case "icecream":
					return 0.6;
					break;
				case "hamburger":
					return 0.6;
					break;
			}
			return 0.6;
		}

		protected function _getRestitution():Number
		{
			switch (peObject)
			{
				case "icecream":
					return 0.3;
					break;
				case "hamburger":
					return 0.3;
					break;
			}
			return 0.3;
		}
	}
}
