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

public class MultiValueParameter extends BaseParameter
{
    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  defaultValue
    //----------------------------------

    private var _defaultValue:Array;

    override public function get defaultValue():Object
    {
        return _defaultValue;
    }

    override public function set defaultValue(value:Object):void
    {
        _defaultValue = value as Array;
    }

    //----------------------------------
    //  type
    //----------------------------------

    override public function get type():String
    {
        return GPParameterTypes.MULTI_VALUE;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public function defaultValueFromString(description:String):void
    {
        if (description)
        {
            defaultValue = description.split(',');
        }
    }

    public override function hasValidValue():Boolean
    {
        var atLeastOneItemSelected:Boolean = false;
        for each (var multiValueItem:MultiValueItem in choiceList)
        {
            if (multiValueItem.selected)
            {
                atLeastOneItemSelected = true;
                break;
            }
        }
        return atLeastOneItemSelected;
    }

    public override function getRequestObjectValue():Object
    {
        var selectedMultiValues:Array = [];
        for each (var multiValueItem:MultiValueItem in choiceList)
        {
            if (multiValueItem.selected)
            {
                selectedMultiValues.push(multiValueItem.item);
            }
        }
        return selectedMultiValues;
    }
}

}
