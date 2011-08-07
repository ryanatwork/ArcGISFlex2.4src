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
package widgets.Geoprocessing.supportClasses
{

import com.esri.ags.FeatureSet;
import com.esri.ags.geometry.Extent;
import com.esri.ags.layers.GraphicsLayer;
import com.esri.ags.utils.GraphicUtil;

import flash.utils.Dictionary;

import mx.collections.ArrayCollection;

import widgets.Geoprocessing.parameters.GPParameterTypes;
import widgets.Geoprocessing.parameters.IGPFeatureParameter;
import widgets.Geoprocessing.parameters.IGPParameter;
import widgets.Geoprocessing.parameters.BaseParamParser;
import widgets.Geoprocessing.parameters.InputParamParser;
import widgets.Geoprocessing.parameters.OutputParamParser;

public class GPParamHandler
{
    public function GPParamHandler(paramsXML:XML)
    {
        var inputParamParser:BaseParamParser = new InputParamParser();
        var outputParamParser:BaseParamParser = new OutputParamParser();
        _inputParams = inputParamParser.parseParameters(paramsXML.inputparams.param);
        _outputParams = outputParamParser.parseParameters(paramsXML.outputparams.param);
        _totalOutputFeatures = getTotalFeatures(_outputParams);
        _totalInputFeatures = getTotalFeatures(_inputParams);

        if (_totalInputFeatures)
        {
            _needsToReprojectInputParams = hasInputSpatialReferences();
        }
    }

    private function getTotalFeatures(params:Array):int
    {
        var total:int = 0;
        var featureParam:IGPFeatureParameter;

        for each (var param:IGPParameter in params)
        {
            if (param.type == GPParameterTypes.FEATURE_RECORD_SET_LAYER)
            {
                featureParam = (param as IGPFeatureParameter);
                total++;
            }
        }

        return total;
    }

    public function getInputParamGeometryMap():Dictionary
    {
        var inputGeometryMap:Dictionary = new Dictionary();
        var inputFeatureSet:FeatureSet;

        for each (var inputParam:IGPParameter in _inputParams)
        {
            if (inputParam.type == GPParameterTypes.FEATURE_RECORD_SET_LAYER)
            {
                inputFeatureSet = (inputParam as IGPFeatureParameter).getRequestObjectValue() as FeatureSet;
                inputGeometryMap[inputParam.name] = GraphicUtil.getGeometries(inputFeatureSet.features);
            }
        }

        return inputGeometryMap;
    }

    private var _needsToReprojectInputParams:Boolean;

    public function get needsToReprojectInputParams():Boolean
    {
        return _needsToReprojectInputParams;
    }

    private function hasInputSpatialReferences():Boolean
    {
        var atLeastOneSpatialReferenceDefined:Boolean = false;

        for each (var inputParam:IGPParameter in _inputParams)
        {
            if (inputParam.type == GPParameterTypes.FEATURE_RECORD_SET_LAYER)
            {
                if ((inputParam as IGPFeatureParameter).spatialReference)
                {
                    atLeastOneSpatialReferenceDefined = true;
                    break;
                }
            }
        }

        return atLeastOneSpatialReferenceDefined;
    }

    private var _totalInputFeatures:int;

    public function get totalInputFeatures():int
    {
        return _totalInputFeatures;
    }

    private var _totalOutputFeatures:int;

    public function get totalOutputFeatures():int
    {
        return _totalOutputFeatures;
    }

    private var _inputParams:Array;

    public function get inputParams():Array
    {
        return _inputParams;
    }

    private var _outputParams:Array;

    public function get outputParams():Array
    {
        return _outputParams;
    }

    public function getVisibleInputParams():Array
    {
        return getVisibleParams(_inputParams);
    }

    private function getVisibleParams(params:Array):Array
    {
        var visibleParams:Array = [];

        for each (var param:IGPParameter in params)
        {
            if (param.visible)
            {
                visibleParams.push(param);
            }
        }

        return visibleParams;
    }

    private function getIncompleteRequiredFields(params:Array):Array
    {
        var incompleteRequiredFields:Array = [];

        for each (var param:IGPParameter in params)
        {
            if (param.required && !param.hasValidValue())
            {
                incompleteRequiredFields.push(param);
            }
        }

        return incompleteRequiredFields;
    }

    public function getIncompleteRequiredInputParams():Array
    {
        return getIncompleteRequiredFields(_inputParams);
    }

    public function createInputRequestObject():Object
    {
        return createRequestObject(_inputParams);
    }

    private function createRequestObject(params:Array):Object
    {
        var requestObject:Object = {};

        for each (var param:IGPParameter in params)
        {
            requestObject[param.name] = param.getRequestObjectValue();
        }

        return requestObject;
    }

    public function findInputParamByName(name:String):IGPParameter
    {
        return findParamByName(name, _inputParams);
    }

    public function findOutputParamByName(name:String):IGPParameter
    {
        return findParamByName(name, _outputParams);
    }

    private function findParamByName(name:String, params:Array):IGPParameter
    {
        var foundParam:IGPParameter;

        for each (var param:IGPParameter in params)
        {
            if (param.name == name)
            {
                foundParam = param;
                break;
            }
        }

        return foundParam;
    }

    public function hasVisibleOutput():Boolean
    {
        var hasVisibleOutputParam:Boolean = false;

        if (outputParams)
        {
            for each (var param:IGPParameter in outputParams)
            {
                if (isVisibleOutputType(param))
                {
                    hasVisibleOutputParam = true;
                    break;
                }
            }
        }

        return hasVisibleOutputParam;
    }

    private function isVisibleOutputType(param:IGPParameter):Boolean
    {
        var isVisibleOutput:Boolean

        switch (param.type)
        {
            case GPParameterTypes.STRING:
            case GPParameterTypes.BOOLEAN:
            case GPParameterTypes.LONG:
            case GPParameterTypes.DOUBLE:
            case GPParameterTypes.DATE:
            case GPParameterTypes.LINEAR_UNIT:
            case GPParameterTypes.RASTER_DATA_LAYER:
            case GPParameterTypes.RECORD_SET:
            case GPParameterTypes.FEATURE_RECORD_SET_LAYER:
            {
                isVisibleOutput = true;
                break;
            }
            default:
            {
                isVisibleOutput = false;
            }
        }

        return isVisibleOutput;
    }

    public function showFeatureLayers():void
    {
        toggleFeatureParameterLayerVisibility(true);
    }

    public function hideFeatureLayers():void
    {
        toggleFeatureParameterLayerVisibility(false);
    }

    public function getOutputFeaturesExtent():Extent
    {
        var featureParam:IGPFeatureParameter;
        var featureGraphicProvider:ArrayCollection;
        var features:Array = [];

        for each (var param:IGPParameter in _outputParams)
        {
            if (param.type == GPParameterTypes.FEATURE_RECORD_SET_LAYER)
            {
                featureParam = (param as IGPFeatureParameter);
                featureGraphicProvider = featureParam.layer.graphicProvider as ArrayCollection;
                features = features.concat(featureGraphicProvider.source);
            }
        }

        return GraphicUtil.getGraphicsExtent(features);
    }

    public function graphicsLayerBelongsToFeatureParam(graphicsLayer:GraphicsLayer):Boolean
    {
        var graphicsLayerBelongsToFeatureParam:Boolean = false;
        var featureParam:IGPFeatureParameter;

        for each (var param:IGPParameter in _outputParams)
        {
            if (param.type == GPParameterTypes.FEATURE_RECORD_SET_LAYER)
            {
                featureParam = (param as IGPFeatureParameter);
                if (featureParam.layer === graphicsLayer)
                {
                    graphicsLayerBelongsToFeatureParam = true;
                    break;
                }
            }
        }

        return graphicsLayerBelongsToFeatureParam;
    }

    private function toggleFeatureParameterLayerVisibility(visible:Boolean):void
    {
        for each (var inputParam:IGPParameter in _inputParams)
        {
            if (inputParam.type == GPParameterTypes.FEATURE_RECORD_SET_LAYER)
            {
                (inputParam as IGPFeatureParameter).layer.visible = visible;
            }
        }

        for each (var outputParam:IGPParameter in _outputParams)
        {
            if (outputParam.type == GPParameterTypes.FEATURE_RECORD_SET_LAYER)
            {
                (outputParam as IGPFeatureParameter).layer.visible = visible;
            }
        }
    }

    public function clearOutputFeatures():void
    {
        for each (var outputParam:IGPParameter in _outputParams)
        {
            if (outputParam.type == GPParameterTypes.FEATURE_RECORD_SET_LAYER)
            {
                (outputParam as IGPFeatureParameter).layer.clear();
            }
        }
    }
}

}
