package ui
{
import away3d.core.math.MathConsts;
import away3d.entities.Mesh;

import com.bit101.components.Label;
import com.bit101.components.Panel;
import com.bit101.components.PushButton;
import com.bit101.components.Text;

import flash.events.Event;
import flash.events.MouseEvent;

/**
 *
 * @author Austin
 *
 */
public class ControllerPanel extends Panel
{
    //==========================================================================
    //  Constructor
    //==========================================================================
    /**
     * Constructs a new <code>ControllerPanel</code> instance.
     *
     */
    public function ControllerPanel()
    {
        super();
        initDisplay();
    }

    private var camBtn:PushButton;
    private var avatarPointTxt:Text;
    private var camPointTxt:Text;
    private var camBtnInfoArr:Array = ["跟随","自由"]
    private var camType:uint = 0;
    private var direTxt:Label;
    private var runningTxt:Label;

    private function initDisplay():void
    {
        this.height = 180;
        var label:Label = new Label();
        label.text = "镜头";
        addChild(label);

        //镜头模式
        camBtn = new PushButton();
        camBtn.addEventListener(MouseEvent.CLICK, camBtn_clickHandler);
        camBtn.label = camBtnInfoArr[0];
        camBtn.y = 0;
        camBtn.x = 40;
        camBtn.width = 50;
        camBtn.height = 18;
        addChild(camBtn);

        //镜头位置
        camPointTxt = new Text();
        camPointTxt.height = 22;
        camPointTxt.y = 17;
        addChild(camPointTxt);

        //化身位置
        var avatarLabel:Label = new Label();
        avatarLabel.text = "化身:";
        avatarLabel.y = 37;
        addChild(avatarLabel);

        avatarPointTxt = new Text();
        avatarPointTxt.height = 22;
        avatarPointTxt.y = 57;
        addChild(avatarPointTxt);

        //化身方向
        var direLabel:Label = new Label();
        direLabel.text = "化身方向:";
        direLabel.y = avatarPointTxt.y + 25;
        addChild(direLabel);

        direTxt = new Label();
        direTxt.height = 22;
        direTxt.x = 50;
        direTxt.y = direLabel.y;
        addChild(direTxt);

        //奔跑状态
        var runningLabel:Label = new Label();
        runningLabel.text = "奔跑状态:";
        runningLabel.y = direLabel.y + 20;
        addChild(runningLabel);

        runningTxt = new Label();
        runningTxt.height = 22;
        runningTxt.x = 50;
        runningTxt.y = runningLabel.y;
        addChild(runningTxt);

        //版本号
        var verLabel:Label = new Label();
        verLabel.text = "Ver: 0.02";
        verLabel.x = 26;
        verLabel.y = 162;
        addChild(verLabel);

    }

    public function setAvatarPoint(x:int,y:int,z:int):void
    {
        avatarPointTxt.text = ("x:"+x+" y:"+y+" z:"+z);
//        avatarPointTxt.htmlText = "x:"+int(mesh.x)+"</br>y:"+int(mesh.y)+"</br>z:"+int(mesh.z);
    }

    public function setCamPoint(x:int,y:int,z:int):void
    {
        camPointTxt.text = ("x:"+x+" y:"+y+" z:"+z);
    }

    public function setDirection(value:int):void
    {
        if (value < 0)
        {
            value =  -value;
        }
        direTxt.text = String(value % 360);
    }

    public function setRunning(value:Boolean):void
    {
        runningTxt.text = value.toString();
    }

    private function camBtn_clickHandler(event:MouseEvent):void
    {
        camType++;
        camType = camType%2;
        camBtn.label = camBtnInfoArr[camType];
        this.dispatchEvent(new Event(Event.CHANGE));
    }
}
}