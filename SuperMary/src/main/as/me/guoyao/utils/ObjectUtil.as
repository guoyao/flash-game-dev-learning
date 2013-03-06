package me.guoyao.utils
{
	import starling.display.Image;

	public class ObjectUtil
	{
		public static function extend(view:Image, params:Object):Object
		{
			if(!params.hasOwnProperty("width"))
				params.width = view.width;
			
			if(!params.hasOwnProperty("height"))
				params.height = view.height;
			
			if(!params.hasOwnProperty("view"))
				params.view = view;
			
			return params;
		}
	}
}