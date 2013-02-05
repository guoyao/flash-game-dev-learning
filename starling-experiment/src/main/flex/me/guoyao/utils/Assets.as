package me.guoyao.utils
{
	import flash.display.Bitmap;
	import flash.text.Font;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets
	{
		[Embed(source = "/../resources/assets/textures/table-tennis.png")]
		public static const TableTennis:Class;
		public static const TABLE_TENNIS:String = "TableTennis";

		[Embed(source = "/../resources/assets/textures/cartoon-1.png")]
		public static const Cartoon1:Class;
		public static const CARTOON_1:String = "Cartoon1";

		[Embed(source = "/../resources/assets/textures/sprite-atlas.png")]
		public static const SpriteSheet:Class;
		public static const SPRITE_SHEET:String = "SpriteSheet";

		[Embed(source = "/../resources/assets/textures/sprite-atlas.xml", mimeType = "application/octet-stream")]
		public static const SpriteSheetXML:Class;
		public static const SPRITE_SHEET_XML:String = "SpriteSheetXML";

		[Embed(source = "/../resources/assets/textures/button.png")]
		public static const ButtonSkin:Class;
		public static const BUTTON_SKIN:String = "ButtonSkin";
		
		[Embed(source = "/../resources/assets/textures/background.jpg")]
		public static const BackgroundSkin:Class;
		public static const BACKGROUND_SKIN:String = "BackgroundSkin";
		
		[Embed(source = '/../resources/assets/fonts/Abduction.ttf', embedAsCFF = 'false', fontName = 'Abduction')]
		public static var AbductionFont:Class;
		public static var ABDUCTION_FONT:String = "AbductionFont";

		private static var textureDictionary:Dictionary = new Dictionary();

		private static var xmlDictionary:Dictionary = new Dictionary();

		private static var textureAtlasDictionary:Dictionary = new Dictionary();
		
		private static var fontDictionary:Dictionary = new Dictionary();

		public static function getTexture(name:String, generateMipMaps:Boolean = true, optimizeForRenderTexture:Boolean = false, scale:Number = 1):Texture
		{
			if (Assets[name] != undefined)
			{
				var key:String = StringUtil.join(StringUtil.DEFAULT_SEPERATOR, name, generateMipMaps, optimizeForRenderTexture, scale);
				if (textureDictionary[key] == undefined)
					textureDictionary[key] = Texture.fromBitmap(new Assets[name]() as Bitmap, generateMipMaps, optimizeForRenderTexture, scale);
				
				return textureDictionary[key];
			}
			else
			{
				throw new Error("Resource not defined.");
			}
		}

		public static function getXML(name:String):XML
		{
			if (Assets[name] != undefined)
			{
				if (xmlDictionary[name] == undefined)
					xmlDictionary[name] = XML(new Assets[name]());
				
				return xmlDictionary[name];
			}
			else
			{
				throw new Error("Resource not defined.");
			}
		}

		public static function getTextureAtlas(name:String, xmlName:String, generateMipMaps:Boolean = true, optimizeForRenderTexture:Boolean = false, scale:Number = 1):TextureAtlas
		{
			if (Assets[name] != undefined && Assets[xmlName] != undefined)
			{
				var key:String = StringUtil.join(StringUtil.DEFAULT_SEPERATOR, name, xmlName, generateMipMaps, optimizeForRenderTexture, scale);
				if (textureAtlasDictionary[key] == undefined)
					textureAtlasDictionary[key] = new TextureAtlas(getTexture(name, generateMipMaps, optimizeForRenderTexture, scale), getXML(xmlName));
				
				return textureAtlasDictionary[key];
			}
			else
			{
				throw new Error("Resource not defined.");
			}
		}
		
		public static function getFont(name:String):Font
		{
			if (Assets[name] != undefined)
			{
				if (fontDictionary[name] == undefined)
					fontDictionary[name] = new Assets[name]();
				
				return fontDictionary[name];
			}
			else
			{
				throw new Error("Resource not defined.");
			}
		}
	}
}
