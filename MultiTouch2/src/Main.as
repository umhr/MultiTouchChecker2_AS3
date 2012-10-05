package
{
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.TouchEvent;
    import flash.text.TextField;
    import flash.ui.Mouse;
    import flash.ui.Multitouch;
    import flash.ui.MultitouchInputMode;
    import net.hires.debug.Stats;
    /**
     * ...
     * @author umhr
     */
	[SWF(width = 800, height = 600, backgroundColor = 0x666666, frameRate = 60)]
    public class Main extends Sprite
    {
        private var _shapeList:Vector.<Pointer> = new Vector.<Pointer>();
        private var _textField:TextField = new TextField();
        public function Main()
        {
            init();
        }
        private function init():void
        {
            if (stage) onInit();
            else addEventListener(Event.ADDED_TO_STAGE, onInit);
        }

        private function onInit(event:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onInit);
            // entry point

            stage.scaleMode = "noScale";
            stage.align = "TL";
            addChild(new Stats());

            Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;

            var text:String = "";
            text += "maxTouchPoints:" + Multitouch.maxTouchPoints;
            text += "\n" + "supportedGestures:" + Multitouch.supportedGestures;
            text += "\n" + "supportsGestureEvents:" + Multitouch.supportsGestureEvents;
            text += "\n" + "supportsTouchEvents:" + Multitouch.supportsTouchEvents;

            _textField.x = 100;
            _textField.width = 400;
            _textField.selectable = false;
            _textField.text = text;
            addChild(_textField);


            if(Multitouch.maxTouchPoints){
                Mouse.hide();
				stage.addEventListener(TouchEvent.TOUCH_MOVE, stage_touchMove);
				stage.addEventListener(TouchEvent.TOUCH_BEGIN, stage_touchBegin);
				stage.addEventListener(TouchEvent.TOUCH_END, stage_touchEnd);

                var n:int = Multitouch.maxTouchPoints;
                for (var i:int = 0; i < n; i++)
                {
                    var shape:Pointer = new Pointer();
					shape.id = i;
                    _shapeList[i] = shape;
                }
            }

        }
		
		private function stage_touchEnd(event:TouchEvent):void 
		{
            var shape:Pointer = _shapeList[event.touchPointID % _shapeList.length];
			removeChild(shape);
		}
		
		private function stage_touchBegin(event:TouchEvent):void 
		{
            var shape:Pointer = _shapeList[event.touchPointID % _shapeList.length];
			addChild(shape);
		}

        private function stage_touchMove(event:TouchEvent):void
        {
            var shape:Pointer = _shapeList[event.touchPointID%_shapeList.length];
            shape.x = event.localX;
            shape.y = event.localY;
			shape.id = event.touchPointID;
			shape.drawLine();
        }

    }

}
