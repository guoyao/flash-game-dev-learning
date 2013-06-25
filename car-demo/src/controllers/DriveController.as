package controllers
{
import away3d.cameras.Camera3D;
import away3d.containers.ObjectContainer3D;

import flash.display.DisplayObject;
import flash.geom.Vector3D;
/**
 * 驾驶视角使用 
 */
import objects3D.cars.CarBase;
/**
 * 
 * @author austin.yue
 * 
 */
public class DriveController extends Object implements ICamaraController
{
    public function DriveController(param1:Camera3D, param2:DisplayObject, param3:CarBase = null)
    {
        this._camara = param1;
        this._stage = param2;
        this._target = param3;
    }
    
    private var _camara:Camera3D;
    private var _stage:DisplayObject;
    private var _target:CarBase;
    private var _activate:Boolean = true;
    
    public function set activate(param1:Boolean):void
    {
        this._activate = param1;
    }
    
    public function get activate():Boolean
    {
        return this._activate;
    }
    
    public function update():void
    {
        if (this._activate && _target)
        {
            this._camara.position = _target.position.add(new Vector3D(0,300,600));
            this._camara.lookAt(_target.position);
        }
    }
}
}