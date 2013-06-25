package objects3D.cars
{
import away3d.entities.Mesh;
import away3d.materials.ColorMaterial;
import away3d.materials.TextureMaterial;
import away3d.primitives.CubeGeometry;
import away3d.primitives.PlaneGeometry;
import away3d.primitives.WireframeAxesGrid;
import away3d.textures.BitmapTexture;

import flash.geom.Vector3D;

import objects3D.autoparts.Wheel;

/**
 * 
 * @author austin.yue
 * 
 */
public class AudiS3 extends CarBase
{
    [Embed(source="/../embeds/models/audi/s3/InteriorSkin.jpg")] 
    private var InteriorMap:Class;
    
    [Embed(source="/../embeds/models/audi/s3/CarShadow.png", mimeType="image/png")] 
    private var ShadowMap:Class;
    
    private var _shadowMaterial:TextureMaterial;

    public function AudiS3(param1:ColorMaterial, param2:ColorMaterial, param3:ColorMaterial, param4:ColorMaterial)
    {
        super(param1,param2,param3,param4);
        
        _interiorMaterial = new TextureMaterial(new BitmapTexture(new InteriorMap().bitmapData));
        _shadowMaterial = new TextureMaterial(new BitmapTexture(new ShadowMap().bitmapData));
        _shadowMaterial.alpha = 0.5;
        shadow = new Mesh(new PlaneGeometry(1120, 1120), _shadowMaterial);
        
        loadModel("models/audi/s3/");
        
        var frPoint:Vector3D = new Vector3D(-142, 70, -236);
        var flPoint:Vector3D = new Vector3D(142, 70, -236);
        var brPoint:Vector3D = new Vector3D(-142, 70, 269);
        var blPoint:Vector3D = new Vector3D(142, 70, 269);
        
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
