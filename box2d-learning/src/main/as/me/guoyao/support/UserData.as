package me.guoyao.support
{
	import flash.display.DisplayObject;

	public class UserData
	{
		public function UserData(breakable:Boolean = false, name:String = null, asset:DisplayObject = null, type:String = null)
		{
			this.breakable = breakable;
			this.name = name;
			this.asset = asset;
			this.type = type;
		}
		
		public var breakable:Boolean;
		
		public var name:String;

		public var asset:DisplayObject;
		
		public var type:String;

		public function toString():String
		{
			return type ? "[Name: " + name + ", Type: " + type + "]" : name;
		}
	}
}