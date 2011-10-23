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

public class MultiValueItem
{
    public var item:String;
    public var selected:Boolean;

    public function MultiValueItem(item:String, selected:Boolean = false)
    {
        this.item = item;
        this.selected = selected;
    }
}

}
