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

import com.esri.ags.SpatialReference;
import com.esri.ags.symbols.SimpleFillSymbol;
import com.esri.ags.symbols.SimpleLineSymbol;
import com.esri.ags.symbols.SimpleMarkerSymbol;

public class InputParamParser extends BaseParamParser
{
    override public function parseParameters(paramsXML:XMLList):Array
    {
        var params:Array = [];
        var param:IGPParameter;

        for each (var paramXML:XML in paramsXML)
        {
            param = GPParameterFactory.getGPParamFromType(paramXML.@type);
            param.defaultValueFromString(String(paramXML.@defaultvalue));
            param.label = paramXML.@label;
            param.name = paramXML.@name;
            param.toolTip = paramXML.@tooltip;
            param.visible = (paramXML.@visible == "true");
            param.required = (paramXML.@required == "true");

            if (paramXML.choicelist[0])
            {
                if (param.type == GPParameterTypes.MULTI_VALUE)
                {
                    param.choiceList = parseMultiValueChoiceList(paramXML.choicelist.choice);
                }
                else
                {
                    param.choiceList = parseChoiceList(paramXML.choicelist.choice);
                }
            }

            var featureParam:IGPFeatureParameter = param as IGPFeatureParameter;
            if (featureParam)
            {
                featureParam.geometryType = paramXML.@geometrytype;
                featureParam.layerName = featureParam.label;

                var wkid:Number = parseFloat(paramXML.@wkid[0]);
                var wkt:String = paramXML.@wkt[0];
                if (wkid || wkt)
                {
                    featureParam.spatialReference = new SpatialReference(wkid, wkt)
                }

                featureParam.renderer = parseRenderer(paramXML.renderer[0], featureParam.geometryType);
            }

            params.push(param);
        }

        return params;
    }

    private function parseMultiValueChoiceList(choiceListXML:XMLList):Array
    {
        var choiceList:Array = [];
        var choiceValue:String;

        for each (var choice:XML in choiceListXML)
        {
            choiceList.push(new MultiValueItem(choice.@value));
        }

        return choiceList;
    }

    private function parseChoiceList(choiceListXML:XMLList):Array
    {
        var choiceList:Array = [];
        var choiceValue:String;

        for each (var choice:XML in choiceListXML)
        {
            choiceValue = choice.@value;
            choiceList.push(choiceValue);
        }

        return choiceList;
    }

    //override default symbols to match draw widget defaults

    override protected function createDefaultPointSymbol():SimpleMarkerSymbol
    {
        return new SimpleMarkerSymbol(SimpleMarkerSymbol.STYLE_CIRCLE, 15, 0x3FAFDC, 1, 0, 0, 0, new SimpleLineSymbol());
    }

    override protected function createDefaultPolygonSymbol():SimpleFillSymbol
    {
        return new SimpleFillSymbol(SimpleFillSymbol.STYLE_SOLID, 0x3FAFDC, 1, new SimpleLineSymbol());
    }

    override protected function createDefaultPolylineSymbol():SimpleLineSymbol
    {
        return new SimpleLineSymbol(SimpleLineSymbol.STYLE_SOLID, 0x3FAFDC, 1, 5);
    }
}
}
