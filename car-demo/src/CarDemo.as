package
{
import away3d.containers.View3D;
import away3d.library.AssetLibrary;
import away3d.lights.DirectionalLight;
import away3d.lights.PointLight;
import away3d.loaders.parsers.Max3DSParser;
import away3d.materials.ColorMaterial;
import away3d.materials.lightpickers.StaticLightPicker;
import away3d.materials.methods.EnvMapMethod;
import away3d.textures.BitmapCubeTexture;
import away3d.textures.BitmapTexture;

import controllers.AutomaticOrbitController;
import controllers.DriveController;
import controllers.ICamaraController;
import controllers.OrbitControllerExtended;

import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

import jiglib.debug.Stats;
import jiglib.plugin.away3d4.Away3D4Physics;

import objects3D.cars.AudiS3;
import objects3D.cars.CarBase;
import objects3D.environments.Garage;

[SWF(width="1024", height="576", frameRate="60", backgroundColor="#000000")]
/**
 * 
 * @author austin.yue
 * 
 */
public class CarDemo extends Sprite
{
    [Embed(source="/../embeds/garage/EnvPosXGarage.jpg")]
    private var EnvPosXGarage:Class;
    [Embed(source="/../embeds/garage/EnvPosYGarage.jpg")]
    private var EnvPosYGarage:Class;
    [Embed(source="/../embeds/garage/EnvPosZGarage.jpg")]
    private var EnvPosZGarage:Class;
    
    [Embed(source="/../embeds/garage/EnvNegXGarage.jpg")]
    private var EnvNegXGarage:Class;
    [Embed(source="/../embeds/garage/EnvNegYGarage.jpg")]
    private var EnvNegYGarage:Class;
    [Embed(source="/../embeds/garage/EnvNegZGarage.jpg")]
    private var EnvNegZGarage:Class;
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>CarDemo</code> instance.
     * 
     */
    public function CarDemo()
    {
        addEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
    }
    
    
    //==========================================================================
    //  Variables
    //==========================================================================
    
    private var viewport:View3D;
    private var bodyMaterial:ColorMaterial;
    private var glassMaterial:ColorMaterial;
    private var bumperMaterial:ColorMaterial;
    private var rimsMaterial:ColorMaterial;
    private var cubeTextures:BitmapCubeTexture;
    private var bodyReflection:EnvMapMethod;
    private var glassReflection:EnvMapMethod;
    private var rimsReflection:EnvMapMethod;
    private var bitmapTexture:BitmapTexture;
    private var garage:Garage;
    private var light:DirectionalLight;
    private var cameraLight:PointLight;
    private var lightPicker:StaticLightPicker;
    
    private var carLib:Array = [];
    
    private var physics:Away3D4Physics;
    private var car:CarBase;
    private var currentController:ICamaraController;
    
    private var perspectiveText:TextField;
    private var perspectiveArr:Array = [];
    private var controllerArr:Array = [];
    private var perspectiveIndex:uint = 0;
    //==========================================================================
    //  Methods
    //==========================================================================
    private function initDisplay():void
    {
//        var sp:Sprite = new Sprite();
//        sp.graphics.beginFill(0xffffff,1);
//        sp.graphics.drawRect(0,0,80,25);
//        sp.graphics.endFill();
//        sp.mouseEnabled = true;
////        sp.cacheAsBitmap = true;
//        sp.x = stage.stageWidth - 80;
//        sp.y = 10;
//        sp.addEventListener(MouseEvent.CLICK, perspectiveText_clickHandler);
//        addChild(sp);
        
        perspectiveText = new TextField();
        perspectiveText.mouseEnabled = true;
        //       perspectiveText.
        perspectiveText.selectable = false;
        perspectiveText.background = true;
        perspectiveText.borderColor = 0xffffff;
        perspectiveText.border = true;
        perspectiveText.borderColor = 0x000000;
        perspectiveText.autoSize = TextFieldAutoSize.CENTER;
        perspectiveText.x = stage.stageWidth - 80;
        perspectiveText.y = 10;
        perspectiveText.addEventListener(MouseEvent.CLICK, perspectiveText_clickHandler);
        addChild(perspectiveText);
    }
    
    private function changePerspective(value:int):void
    {
        currentController = controllerArr[value];
        
        perspectiveText.text = perspectiveArr[value];
    }
    
    private function init3D() : void
    {
        //允许解析所有支持格式的3d模型文件,但不推荐使用会让swf变大
        //        Parsers.enableAllBundled();
        //仅允许解析3ds格式的模型文件
        AssetLibrary.enableParser(Max3DSParser);
        
        //jiglib物理引擎初始化
        physics = new Away3D4Physics(viewport, 6);
        
        this.viewport = new View3D();
        this.viewport.antiAlias = 0;
        addChild(this.viewport);
        
        this.light = new DirectionalLight(0, -1, 0);
        this.light.color = 0xEEEEEE;
        this.cameraLight = new PointLight();
        this.cameraLight.color = 0x777777;
        this.lightPicker = new StaticLightPicker([this.light, this.cameraLight]);
        
        //实例化车库
        this.garage = new Garage(physics, light);
        
        //车库贴图
        this.cubeTextures = 
            new BitmapCubeTexture(new this.EnvPosXGarage().bitmapData, 
                new this.EnvNegXGarage().bitmapData, 
                new this.EnvPosYGarage().bitmapData, 
                new this.EnvNegYGarage().bitmapData, 
                new this.EnvPosZGarage().bitmapData, 
                new this.EnvNegZGarage().bitmapData);
        
        //环境贴图模式,让车身可以有镜面效果
        this.bodyReflection = new EnvMapMethod(this.cubeTextures, 0.3);
        this.glassReflection = new EnvMapMethod(this.cubeTextures);
        this.rimsReflection = new EnvMapMethod(this.cubeTextures, 0.5);
        
        //车架贴图
        this.bodyMaterial = new ColorMaterial(0x242424);
        this.bodyMaterial.specular = 1;
        this.bodyMaterial.lightPicker = this.lightPicker;
        this.bodyMaterial.addMethod(this.bodyReflection);
        
        //玻璃贴图
        this.glassMaterial = new ColorMaterial(0xFFFFFF, 0.4);
        this.glassMaterial.specular = 1;
        this.glassMaterial.lightPicker = this.lightPicker;
        this.glassMaterial.addMethod(this.glassReflection);
        
        //车轮壳贴图
        this.rimsMaterial = new ColorMaterial(0xEEEEEE);
        this.rimsMaterial.specular = 0.5;
        this.rimsMaterial.lightPicker = this.lightPicker;
        this.rimsMaterial.addMethod(this.rimsReflection);
        
        //车壳贴图
        this.bumperMaterial = new ColorMaterial(0x444444);
        this.bumperMaterial.specular = 0.1;
        this.bumperMaterial.lightPicker = this.lightPicker;
        this.bumperMaterial.addMethod(this.rimsReflection);
        
        //实例化汽车模型
//        car = createCar(FerrariCalifornia);
//        car = createCar(MercedesMCLarenSLR500);
//        car = createCar(MitsubishiLancerX);
//        car = createCar(ChevroletCamaro);
//        car = createCar(AstonMartinVintage);
//        car = createCar(Nissan350z);
        car = car = createCar(AudiS3)
        car.visible = true
        
        physics.addBody(car.chassis);
        
        viewport.scene.addChild(light);
        viewport.scene.addChild(cameraLight);
        viewport.scene.addChild(garage);
        
        //物理引擎性能显示组件
        this.addChild(new Stats(viewport, physics));
    }
    
    private function initCamaraController():void
    {
        //自动视角控制器
        perspectiveArr.push("自动视角");
        currentController = new AutomaticOrbitController(viewport.camera, viewport);
        controllerArr.push(currentController);
        //手动视角控制器
        perspectiveArr.push("手动视角");
        currentController = new OrbitControllerExtended(viewport.camera, viewport);
        controllerArr.push(currentController);
        //驾驶视角控制器
        perspectiveArr.push("驾驶视角");
        currentController = new DriveController(viewport.camera, viewport, car);
        controllerArr.push(currentController);
        
        changePerspective(0)
    }
    
    private function createCar(CarClz:Class):CarBase
    {
        var car:CarBase = new CarClz(bodyMaterial, glassMaterial, bumperMaterial, rimsMaterial);
        car.visible = false;
        viewport.scene.addChild(car);
        carLib.push(car);
        return car;
    }
    
    //==========================================================================
    //  Event Handlers
    //==========================================================================
    
    private function addedToStage(event:Event) : void
    {
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        addEventListener(Event.ENTER_FRAME, this.renderScene);
        removeEventListener(Event.ADDED_TO_STAGE, this.addedToStage);
        stage.addEventListener(Event.RESIZE, this.stageResize);
        init3D();
        initDisplay();
        initCamaraController();
        stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler );
        stage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler );
    }
    
    private function stageResize(event:Event) : void
    {
        viewport.width = stage.stageWidth;
        viewport.height = stage.stageHeight;
        
        perspectiveText.x = stage.stageWidth - perspectiveText.textWidth + 10;
    }
    
    private function renderScene(event:Event) : void
    {
        cameraLight.position = viewport.camera.position;
        viewport.render();
        car.update();
        currentController.update();
        physics.step(0.1);
//        this.bodyMaterial.color = this.gui.bodyColorPicker.getColor;
//        this.rimsMaterial.color = this.gui.rimsColorPicker.getColor;
    }
    
    private function keyDownHandler(event :KeyboardEvent):void
    {
        car.driveCar(true, event.keyCode);
    }
    
    private function keyUpHandler(event:KeyboardEvent):void
    {
        car.driveCar(false, event.keyCode);
    }
    
    private function perspectiveText_clickHandler(event:MouseEvent):void
    {
        perspectiveIndex++;
        changePerspective(perspectiveIndex%3);
    }
}
}