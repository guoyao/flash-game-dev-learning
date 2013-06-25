package objects3D.environments
{
import away3d.containers.ObjectContainer3D;
import away3d.entities.Mesh;
import away3d.events.AssetEvent;
import away3d.library.assets.AssetType;
import away3d.lights.DirectionalLight;
import away3d.loaders.Loader3D;
import away3d.materials.TextureMaterial;
import away3d.materials.lightpickers.StaticLightPicker;
import away3d.materials.methods.TerrainDiffuseMethod;
import away3d.primitives.PlaneGeometry;
import away3d.textures.BitmapTexture;

import flash.geom.Vector3D;

import jiglib.geometry.JPlane;
import jiglib.plugin.away3d4.Away3D4Mesh;
import jiglib.plugin.away3d4.Away3D4Physics;


public class Garage extends ObjectContainer3D
{
    [Embed(source="/../embeds/garage/FloorMap.jpg")]
    private var FloorMapAsset:Class;

    [Embed(source="/../embeds/garage/GarageMap.jpg")]
    private var GarageMapAsset:Class;

    [Embed(source="/../embeds/garage/FloorShadowMap.png", mimeType="image/png")]
    private var FloorShadowMapAsset:Class;

    [Embed(source="/../embeds/garage/Garage.3DS", mimeType="application/octet-stream")]
    private var GarageAsset:Class;

    private var garageMesh:Mesh;
    private var floorMesh:Mesh;
    private var floorShadowMesh:Mesh;

    public function Garage(physics:Away3D4Physics, param1:DirectionalLight = null)
    {
        var floorMapTexture:BitmapTexture = 
            new BitmapTexture(new this.FloorMapAsset().bitmapData);
        var floorMap:TextureMaterial = 
            new TextureMaterial(floorMapTexture, true, true);
        floorMap.specular = 1;
        floorMap.lightPicker = new StaticLightPicker([param1]);
        floorMap.diffuseMethod = new TerrainDiffuseMethod([floorMapTexture], 
            new BitmapTexture(new this.FloorShadowMapAsset().bitmapData), [10]);
        
        var floorShadow:TextureMaterial = 
            new TextureMaterial(new BitmapTexture(new this.FloorShadowMapAsset().bitmapData));
        floorShadow.alpha = 0.9;
        
        var plane:PlaneGeometry = new PlaneGeometry(3800, 3800);
        
        //地板上的阴影
        floorShadowMesh = new Mesh(plane, floorShadow);
        floorShadowMesh.y = -229;
        floorShadowMesh.rotationY = -95;
        
        //车库地板
        floorMesh = new Mesh(plane, floorMap);
        //将车库地面设置为刚体
        var jGround:JPlane = 
            new JPlane(new Away3D4Mesh(floorMesh),new Vector3D(0, 1, 0));
        jGround.y = -230;
        jGround.rotationY = -95;
        jGround.movable = false;
        physics.addBody(jGround);
        
        //建筑
        var garageLoader:Loader3D = new Loader3D();
        garageLoader.addEventListener(AssetEvent.ASSET_COMPLETE, this.complete);
        garageLoader.loadData(new this.GarageAsset(), null, null);
        addChildren(floorMesh, floorShadowMesh);
    }
    
    
    private function complete(event:AssetEvent):void
    {
        if (event.asset.assetType == AssetType.MESH)
        {
            garageMesh = event.asset as Mesh;
            garageMesh.material = 
                new TextureMaterial(new BitmapTexture(
                    new this.GarageMapAsset().bitmapData), true);
            garageMesh.roll(180);
            garageMesh.geometry.scale(3);
            garageMesh.y = 120;
            addChild(this.garageMesh);
//            super.y = 188;
        }
    }

}
}
