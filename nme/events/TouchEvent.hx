#if flash


package nme.events;


@:native ("flash.events.TouchEvent")
@:require(flash10_1) extern class TouchEvent extends Event {
	var altKey : Bool;
	var ctrlKey : Bool;
	var isPrimaryTouchPoint : Bool;
	var isRelatedObjectInaccessible : Bool;
	var localX : Float;
	var localY : Float;
	var pressure : Float;
	var relatedObject : nme.display.InteractiveObject;
	var shiftKey : Bool;
	var sizeX : Float;
	var sizeY : Float;
	var stageX(default,null) : Float;
	var stageY(default,null) : Float;
	var touchPointID : Int;
	function new(type : String, bubbles : Bool = true, cancelable : Bool = false, touchPointID : Int = 0, isPrimaryTouchPoint : Bool = false, localX : Float = 0./*NaN*/, localY : Float = 0./*NaN*/, sizeX : Float = 0./*NaN*/, sizeY : Float = 0./*NaN*/, pressure : Float = 0./*NaN*/, ?relatedObject : nme.display.InteractiveObject, ctrlKey : Bool = false, altKey : Bool = false, shiftKey : Bool = false) : Void;
	function updateAfterEvent() : Void;
	static var TOUCH_BEGIN : String;
	static var TOUCH_END : String;
	static var TOUCH_MOVE : String;
	static var TOUCH_OUT : String;
	static var TOUCH_OVER : String;
	static var TOUCH_ROLL_OUT : String;
	static var TOUCH_ROLL_OVER : String;
	static var TOUCH_TAP : String;
}



#else


package nme.events;

import nme.display.InteractiveObject;
import nme.geom.Point;

class TouchEvent extends nme.events.MouseEvent
{
   public static var TOUCH_BEGIN : String = "touchBegin";
   public static var TOUCH_END : String = "touchEnd";
   public static var TOUCH_MOVE : String = "touchMove";
   public static var TOUCH_OUT : String = "touchOut";
   public static var TOUCH_OVER : String = "touchOver";
   public static var TOUCH_ROLL_OUT : String = "touchRollOut";
   public static var TOUCH_ROLL_OVER : String = "touchRollOver";
   public static var TOUCH_TAP : String = "touchTap";

   public var touchPointID : Int;
   public var isPrimaryTouchPoint : Bool;


   public function new(type : String,
            bubbles : Bool = true, 
            cancelable : Bool = false,
            in_localX : Float = 0,
            in_localY : Float = 0,
            in_relatedObject : InteractiveObject = null,
            in_ctrlKey : Bool = false,
            in_altKey : Bool = false,
            in_shiftKey : Bool = false,
            in_buttonDown : Bool = false,
            in_delta : Int = 0,
            in_commandKey:Bool = false,
            in_clickCount:Int = 0 )
   {
      super(type,bubbles,cancelable,in_localX,in_localY, in_relatedObject,
        in_ctrlKey, in_altKey, in_shiftKey, in_buttonDown, in_delta,
        in_commandKey, in_clickCount );
      touchPointID = 0;
      isPrimaryTouchPoint = true;
   }

   public static function nmeCreate(inType:String, inEvent:Dynamic,inLocal:Point,
      inTarget:InteractiveObject)
   {
      var flags : Int = inEvent.flags;
      var evt = new TouchEvent(inType, true, false, inLocal.x, inLocal.y, null,
           (flags & MouseEvent.efCtrlDown) != 0,
           (flags & MouseEvent.efAltDown) != 0,
           (flags & MouseEvent.efShiftDown) != 0,
           (flags & MouseEvent.efLeftDown) != 0,
           0,0 );
      evt.stageX = inEvent.x;
      evt.stageY = inEvent.y;
      evt.target = inTarget;
      return evt;
   }

   override public function nmeCreateSimilar(inType:String,
        ?related:InteractiveObject,?targ:InteractiveObject) : MouseEvent
   {
      var result = new TouchEvent(inType,bubbles,cancelable,localX,localY,
         related==null ? relatedObject : related,
         ctrlKey, altKey, shiftKey, buttonDown, delta, commandKey, clickCount );

      result.touchPointID = touchPointID;
      result.isPrimaryTouchPoint = isPrimaryTouchPoint;
      if (targ!=null)
         result.target = targ;
      return result;
   }

}


#end