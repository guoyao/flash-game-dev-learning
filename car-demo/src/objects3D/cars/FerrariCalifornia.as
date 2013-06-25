package objects3D.cars
{
import away3d.entities.Mesh;
import away3d.materials.ColorMaterial;
import away3d.materials.TextureMaterial;
import away3d.primitives.PlaneGeometry;
import away3d.textures.BitmapTexture;

import flash.geom.Vector3D;

import objects3D.autoparts.Wheel;
/**
 * 
 * @author austin.yue
 * 
 */
public class FerrariCalifornia extends CarBase
{
    
    [Embed(source="models/ferrari/california/InteriorSkin.jpg")] 
    private var InteriorMap:Class;
    
    [Embed(source="models/audi/s3/CarShadow.png", mimeType="image/png")] 
    private var ShadowMap:Class;
    
    private var _shadowMaterial:TextureMaterial;

    public function FerrariCalifornia(param1:ColorMaterial, param2:ColorMaterial, param3:ColorMaterial, param4:ColorMaterial)
    {
        super(param1, param2, param3, param4);

        this._interiorMaterial = new TextureMaterial(new BitmapTexture(new this.InteriorMap().bitmapData));
        this._shadowMaterial = new TextureMaterial(new BitmapTexture(new this.ShadowMap().bitmapData));
        this._shadowMaterial.alpha = 0.5;
        this.shadow = new Mesh(new PlaneGeometry(1120, 1120), this._shadowMaterial);
        this.shadow.y = 3;

        loadModel("models/ferrari/california/");
        
        var frPoint:Vector3D = new Vector3D(-150, 70, -265);
        var flPoint:Vector3D = new Vector3D(150, 70, -265);
        var brPoint:Vector3D = new Vector3D(-154, 70, 245);
        var blPoint:Vector3D = new Vector3D(154, 70, 245);

        frontRightWheel = new Wheel(param4, "camaro", "right");
        frontRightWheel.position = frPoint;
        frontLeftWheel = new Wheel(param4, "camaro", "left");
        frontLeftWheel.position = flPoint;
        backRightWheel = new Wheel(param4, "camaro", "right");
        backRightWheel.position = brPoint;
        backLeftWheel = new Wheel(param4, "camaro", "left");
        backLeftWheel.position = blPoint;
        
        
        //检测中心坐标
//        var c:WireframeAxesGrid = new WireframeAxesGrid(10,800)
////        c.y = -155;
//        addChild(c);
        
        //检测全车位置与尺寸
//        var c:CubeGeometry = new CubeGeometry(380,290,820);
//        var m:Mesh = new Mesh(c, new ColorMaterial(0xff0000,0.3));
////        m.y = 155;
//        addChild(m);
        
        //检测车轮定位与尺寸
//        var c:CylinderGeometry = new CylinderGeometry(68,68,1);
//        var m:Mesh = new Mesh(c, new ColorMaterial(0xff0000));
//        m.position = flPoint;
//        m.roll(90)
//        addChild(m);
        
        carBody.chassis.sideLengths = new Vector3D(380, 290, 820);
        var t:Vector3D = new Vector3D(0,FIX_TARGET_Y,0)
        carBody.setupWheel(WheelConst.FL, flPoint.add(t), 1.3, 1.3, 6, 75, 0.5, 0.5, 2);
        carBody.setupWheel(WheelConst.FR, frPoint.add(t), 1.3, 1.3, 6, 75, 0.5, 0.5, 2);
        carBody.setupWheel(WheelConst.BL, blPoint.add(t), 1.3, 1.3, 6, 75, 0.5, 0.5, 2);
        carBody.setupWheel(WheelConst.BR, brPoint.add(t), 1.3, 1.3, 6, 75, 0.5, 0.5, 2);
    }
}
}
