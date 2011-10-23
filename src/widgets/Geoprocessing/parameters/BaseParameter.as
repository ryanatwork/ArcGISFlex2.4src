////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2011 Esri
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/License.txt
//
////////////////////////////////////////////////////////////////////////////////
package widgets.Geoprocessing.parameters
{

public class BaseParameter implements IGPParameter
{
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  label
    //----------------------------------

    private var _label:String;

    public function get label():String
    {
        return _label;
    }

    public function set label(value:String):void
    {
        _label = value;
    }

    //----------------------------------
    //  name
    //----------------------------------

    private var _name:String;

    public function get name():String
    {
        return _name;
    }

    public function set name(value:String):void
    {
        _name = value;
    }

    //----------------------------------
    //  type
    //----------------------------------

    private var _type:String;

    public function get type():String
    {
        return _type;
    }

    //----------------------------------
    //  direction
    //----------------------------------

    private var _direction:String;

    public function get direction():String
    {
        return _direction;
    }

    public function set direction(value:String):void
    {
        _direction = value;
    }

    //----------------------------------
    //  defaultValue
    //----------------------------------

    private var _defaultValue:Object;

    public function get defaultValue():Object
    {
        return _defaultValue;
    }

    public function set defaultValue(value:Object):void
    {
        _defaultValue = value;
    }

    //----------------------------------
    //  choiceList
    //----------------------------------

    private var _choiceList:Array;

    public function get choiceList():Array
    {
        return _choiceList;
    }

    public function set choiceList(value:Array):void
    {
        _choiceList = value;
    }

    //----------------------------------
    //  tooltip
    //----------------------------------

    private var _toolTip:String;

    public function get toolTip():String
    {
        return _toolTip;
    }

    public function set toolTip(value:String):void
    {
        _toolTip = value;
    }

    //----------------------------------
    //  visible
    //----------------------------------

    private var _visible:Boolean = true;

    public function get visible():Boolean
    {
        return _visible;
    }

    public function set visible(value:Boolean):void
    {
        _visible = value;
    }

    //----------------------------------
    //  required
    //----------------------------------

    private var _required:Boolean;

    public function get required():Boolean
    {
        return _required;
    }

    public function set required(value:Boolean):void
    {
        _required = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     * Extending classes should override this method if value cannot be casted from String.
     */
    public function defaultValueFromString(text:String):void
    {
        defaultValue = text;
    }

    public function getRequestObjectValue():Object
    {
        return defaultValue;
    }

    public function hasValidValue():Boolean
    {
        return defaultValue;
    }
}

}
