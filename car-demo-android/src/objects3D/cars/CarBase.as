package objects3D.cars
{
import away3d.containers.ObjectContainer3D;
import away3d.entities.Mesh;
import away3d.events.AssetEvent;
import away3d.library.assets.AssetType;
import away3d.loaders.Loader3D;
import away3d.materials.ColorMaterial;
import away3d.materials.TextureMaterial;

import flash.geom.Vector3D;
import flash.net.URLRequest;
import flash.ui.Keyboard;

import jiglib.math.JMatrix3D;
import jiglib.vehicles.JCar;
import jiglib.vehicles.JChassis;

import objects3D.autoparts.Wheel;
import objects3D.environments.Smoke;

/**
 * 
 * @author austin.yue
 * 
 */
public class CarBase extends ObjectContainer3D
{
    static protected const FIX_TARGET_Y:int = -155;
    //==========================================================================
    //  Class variables
    //==========================================================================
    
    static private const frontWheelArr:Array = [WheelConst.FL, WheelConst.FR];
    
    
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>CarBase</code> instance.
     * 
     */
    public function CarBase(param1:ColorMaterial, 
                            param2:ColorMaterial, 
                            param3:ColorMaterial, 
                            param4:ColorMaterial)
    {
        super();
        initPhysics();
        _bodyMaterial = param1;
        _glassMaterial = param2;
        _bumperMaterial = param3;
    }
    
    //==========================================================================
    //  Variables
    //==========================================================================
    
    public var body:Mesh;
    public var glass:Mesh;
    public var shadow:Mesh;
    public var interior:Mesh;
    public var bumper:Mesh;
    
    protected var _modelLoaded:Boolean = false;
    
    protected var _bodyMaterial:ColorMaterial;
    protected var _glassMaterial:ColorMaterial;
    protected var _bumperMaterial:ColorMaterial;
    protected var _interiorMaterial:TextureMaterial;
    
    public var frontRightWheel:Wheel;
    public var frontLeftWheel:Wheel;
    public var backRightWheel:Wheel;
    public var backLeftWheel:Wheel;
    
    protected var carBody:JCar;
    
    //==========================================================================
    //  Properties
    //==========================================================================
    
    public function get chassis():JChassis
    {
        return carBody.chassis;
    }
    
    //==========================================================================
    //  Methods
    //==========================================================================
    
    
    protected function initPhysics():void
    {
        carBody = new JCar(null);
        carBody.setCar(40, 1, 2000);
//        carBody.chassis.rotationY = 90;
        
        carBody.chassis.mass = 10;
    }
    
    /**
     * 根据路径加载3D模型 
     * @param path
     */    
    protected function loadModel(path:String):void
    {
        var bodyLoader:Loader3D = new Loader3D();
        bodyLoader.addEventListener(AssetEvent.ASSET_COMPLETE, car_bodyCompleteHandler);
        bodyLoader.load(new URLRequest(path+"body.3DS"));
        
        var glassLoader:Loader3D = new Loader3D();
        glassLoader.addEventListener(AssetEvent.ASSET_COMPLETE, car_glassCompleteHandler);
        glassLoader.load(new URLRequest(path+"glass.3DS"));
        
        var interiorLoader:Loader3D = new Loader3D();
        interiorLoader.addEventListener(AssetEvent.ASSET_COMPLETE, car_interiorCompleteHandler);
        interiorLoader.load(new URLRequest(path+"interior.3DS"));
        
        var bomperLoader:Loader3D = new Loader3D();
        bomperLoader.addEventListener(AssetEvent.ASSET_COMPLETE, car_bomperCompleteHandler);
        bomperLoader.load(new URLRequest(path+"bumper.3dS"));
    }
    
    public function update():void
    {       
        this.transform = JMatrix3D.getAppendMatrix3D(carBody.chassis.currentState.orientation, 
            JMatrix3D.getTranslationMatrix(carBody.chassis.currentState.position.x, 
                carBody.chassis.currentState.position.y, 
                carBody.chassis.currentState.position.z));

//        trace(carBody.getNumWheelsOnFloor())
        frontLeftWheel.pitch(carBody.wheels[WheelConst.FL].getRollAngle());
        frontRightWheel.pitch(carBody.wheels[WheelConst.FR].getRollAngle());
        backLeftWheel.pitch(carBody.wheels[WheelConst.BL].getRollAngle());
        backRightWheel.pitch(carBody.wheels[WheelConst.BR].getRollAngle());
        
        frontLeftWheel.rotationY = carBody.wheels[WheelConst.FL].getSteerAngle();
        frontRightWheel.rotationY = carBody.wheels[WheelConst.FR].getSteerAngle();
        
        frontLeftWheel.y = carBody.wheels[WheelConst.FL].getActualPos().y;
        frontRightWheel.y = carBody.wheels[WheelConst.FR].getActualPos().y;
        backLeftWheel.y = carBody.wheels[WheelConst.BL].getActualPos().y;
        backRightWheel.y = carBody.wheels[WheelConst.BR].getActualPos().y;
    }
    
//    public function replaceReflectionMaps(param1:Array) : void
//    {
//        return;
//    }
    
    public function driveCar(isRunning:Boolean, keyCode:int) : void
    {
        if (isRunning)
        {
            //键盘按键按下时触发
            switch(keyCode)
            {
                case Keyboard.UP:
                    carBody.setAccelerate(-1);
                    break;
                case Keyboard.DOWN:
                    carBody.setAccelerate(1); 
                    break;
                case Keyboard.LEFT:
                    carBody.setSteer(frontWheelArr, -1);
                    break;
                case Keyboard.RIGHT:
                    carBody.setSteer(frontWheelArr, 1);
                    break;
                case Keyboard.SPACE:
                    carBody.setHBrake(1);
                    break;
            }
        }
        else
        {
            //键盘按键弹起时触发
            switch(keyCode)
            {
                case Keyboard.UP:
                    carBody.setAccelerate(0);
                    break;
                
                case Keyboard.DOWN:
                    carBody.setAccelerate(0);
                    break;
                
                case Keyboard.LEFT:
                    carBody.setSteer(frontWheelArr, 0);
                    break;
                
                case Keyboard.RIGHT:
                    carBody.setSteer(frontWheelArr, 0);
                    break;
                case Keyboard.SPACE:
                    carBody.setHBrake(0);
                    break;
            }
        }
    }
    
    private function initSmoke():void
    {
        var smoke:Smoke = new Smoke();
        smoke.x = 40;
        smoke.y = FIX_TARGET_Y + 60;
        smoke.z = -400;
        addChild(smoke);
    }
    
    //==========================================================================
    //  Event Handlers
    //==========================================================================
    /**
     * 车架加载完成后触发  
     * @param event
     */    
    protected function car_bodyCompleteHandler(event:AssetEvent) : void
    {
        if (event.asset.assetType == AssetType.MESH)
        {
            body = event.asset as Mesh;
            body.y += FIX_TARGET_Y;
            body.material = this._bodyMaterial;
            addChild(body);
            super.addChild(shadow);
            addChildren(frontRightWheel, frontLeftWheel, backRightWheel, backLeftWheel);
            
            shadow.y += (FIX_TARGET_Y + 10);
            initSmoke();
        }
        this._modelLoaded = true;
    }
    
    /**
     * 玻璃加载完成后触发  
     * @param event
     */    
    protected function car_glassCompleteHandler(event:AssetEvent) : void
    {
        if (event.asset.assetType == AssetType.MESH)
        {
            glass = event.asset as Mesh;
            glass.y += FIX_TARGET_Y;
            glass.material = _glassMaterial;
            addChild(glass);
        }
    }
    
    protected function car_interiorCompleteHandler(event:AssetEvent) : void
    {
        if (event.asset.assetType == AssetType.MESH)
        {
            interior = event.asset as Mesh;
            interior.y += FIX_TARGET_Y;
            interior.material = _interiorMaterial;
            addChild(interior);
        }
    }
    
    /**
     * 车壳加载完成后触发 
     * @param event
     */    
    protected function car_bomperCompleteHandler(event:AssetEvent) : void
    {
        if (event.asset.assetType == AssetType.MESH)
        {
            bumper = event.asset as Mesh;
            bumper.y += FIX_TARGET_Y;
            bumper.material = this._bumperMaterial;
            addChild(bumper);
        }
    }
}
}