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
public class AstonMartinVintage extends CarBase
{
    [Embed(source="models/aston-martin/vantage/InteriorSkin.jpg")] 
    private var InteriorMap:Class;
    
    [Embed(source="models/aston-martin/vantage/CarShadow.png", mimeType="image/png")] 
    private var ShadowMap:Class;
    
    private var _shadowMaterial:TextureMaterial;

    public function AstonMartinVintage(param1:ColorMaterial, param2:ColorMaterial, param3:ColorMaterial, param4:ColorMaterial)
    {
        super(param1,param2,param3,param4);
        
        this._interiorMaterial = new TextureMaterial(new BitmapTexture(new this.InteriorMap().bitmapData));
        this._shadowMaterial = new TextureMaterial(new BitmapTexture(new this.ShadowMap().bitmapData));
        this._shadowMaterial.alpha = 0.5;
        this.shadow = new Mesh(new PlaneGeometry(1120, 1120), this._shadowMaterial);
        this.shadow.y = 3;
        
        loadModel("models/aston-martin/vantage/");
        
        var frPoint:Vector3D = new Vector3D(-160, 70, -270);
        var flPoint:Vector3D = new Vector3D(160, 70, -270);
        var brPoint:Vector3D = new Vector3D(-155, 70, 245);
        var blPoint:Vector3D = new Vector3D(155, 70, 245);

        this.frontRightWheel = new Wheel(param4, "camaro", "right");
        this.frontRightWheel.position = frPoint;
        this.frontLeftWheel = new Wheel(param4, "camaro", "left");
        this.frontLeftWheel.position = flPoint;
        this.backRightWheel = new Wheel(param4, "camaro", "right");
        this.backRightWheel.position = brPoint;
        this.backLeftWheel = new Wheel(param4, "camaro", "left");
        this.backLeftWheel.position = blPoint;
        
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
