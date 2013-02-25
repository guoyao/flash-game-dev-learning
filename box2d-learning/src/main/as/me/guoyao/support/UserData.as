package me.guoyao.support
{
	public class UserData
	{
		public function UserData(breakable:Boolean = true, name:String = null, type:String = null)
		{
			this._breakable = breakable;
			this._name = name;
			this._type = type;
		}
		
		private var _breakable:Boolean;
		
		public function get breakable():Boolean
		{
			return _breakable;
		}
		
		private var _name:String;

		public function get name():String
		{
			return _name;
		}
		
		private var _type:String;

		public function get type():String
		{
			return _type;
		}
	}
}