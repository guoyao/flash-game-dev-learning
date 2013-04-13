package me.guoyao.utils
{
	public class StringUtil
	{
		public static const DEFAULT_SEPERATOR:String = "-";
		
		public static function join(seperator:String, ...params):String
		{
			return params.join(seperator);
		}
	}
}