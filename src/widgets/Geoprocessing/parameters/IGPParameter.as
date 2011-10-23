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

public interface IGPParameter
{
    function get name():String;
    function get label():String;
    function get type():String;
    function get defaultValue():Object;
    function get choiceList():Array;
    function get toolTip():String;
    function get visible():Boolean;
    function get required():Boolean;

    function set name(value:String):void;
    function set label(value:String):void;
    function set defaultValue(value:Object):void;
    function set choiceList(value:Array):void;
    function set toolTip(value:String):void;
    function set visible(value:Boolean):void;
    function set required(value:Boolean):void;

    function defaultValueFromString(description:String):void;
    function hasValidValue():Boolean;
    function getRequestObjectValue():Object;
}

}
