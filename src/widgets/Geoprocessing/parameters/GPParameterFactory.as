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

public class GPParameterFactory
{
    public static function getGPParamFromType(type:String):IGPParameter
    {
        var gpParam:IGPParameter;

        switch (type)
        {
            case GPParameterTypes.BOOLEAN:
            {
                gpParam = new BooleanParameter();
                break;
            }
            case GPParameterTypes.DATA_FILE:
            {
                gpParam = new DataFileParameter();
                break;
            }
            case GPParameterTypes.DATE:
            {
                gpParam = new DateParameter();
                break;
            }
            case GPParameterTypes.DOUBLE:
            {
                gpParam = new DoubleParameter();
                break;
            }
            case GPParameterTypes.FEATURE_RECORD_SET_LAYER:
            {
                gpParam = new FeatureLayerParameter();
                break;
            }
            case GPParameterTypes.LINEAR_UNIT:
            {
                gpParam = new LinearUnitParameter();
                break;
            }
            case GPParameterTypes.LONG:
            {
                gpParam = new LongParameter();
                break;
            }
            case GPParameterTypes.MULTI_VALUE:
            {
                gpParam = new MultiValueParameter();
                break;
            }
            case GPParameterTypes.RASTER_DATA_LAYER:
            {
                gpParam = new RasterDataLayerParam();
                break;
            }
            case GPParameterTypes.RECORD_SET:
            {
                gpParam = new RecordSetParameter();
                break;
            }
            case GPParameterTypes.STRING:
            {
                gpParam = new StringParameter();
                break;
            }
        }

        return gpParam;
    }
}

}
