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

import com.esri.ags.webmap.supportClasses.PopUpFieldFormat;
import com.esri.ags.webmap.supportClasses.PopUpFieldInfo;
import com.esri.ags.webmap.supportClasses.PopUpInfo;
import com.esri.ags.webmap.supportClasses.PopUpMediaInfo;

public class OutputParamParser extends BaseParamParser
{
    override public function parseParameters(paramsXML:XMLList):Array
    {
        var params:Array = [];
        var param:IGPParameter;

        for each (var paramXML:XML in paramsXML)
        {
            param = GPParameterFactory.getGPParamFromType(paramXML.@type);
            param.label = paramXML.@label;
            param.name = paramXML.@name;
            param.toolTip = paramXML.@tooltip;

            var featureParam:IGPFeatureParameter = param as IGPFeatureParameter;
            if (featureParam)
            {
                featureParam.geometryType = paramXML.@geometrytype;
                featureParam.layerName = featureParam.label;

                if (paramXML.popup[0])
                {
                    featureParam.popUpInfo = parsePopUpInfo(paramXML.popup[0]);
                }

                featureParam.renderer = parseRenderer(paramXML.renderer[0], featureParam.geometryType);
            }

            params.push(param);
        }

        return params;
    }

    private function parsePopUpInfo(popUpXML:XML):PopUpInfo
    {
        var popUpInfo:PopUpInfo = new PopUpInfo();

        if (popUpXML.title[0])
        {
            popUpInfo.title = popUpXML.title;
        }

        if (popUpXML.description[0])
        {
            popUpInfo.description = popUpXML.description;
        }

        if (popUpXML.fields[0])
        {
            popUpInfo.popUpFieldInfos = parsePopUpFields(popUpXML.fields[0]);
        }

        if (popUpXML.medias[0])
        {
            popUpInfo.popUpMediaInfos = parsePopUpMedias(popUpXML.medias[0]);
        }

        if (popUpXML.showattachments[0])
        {
            popUpInfo.showAttachments = (popUpXML.showattachments == "true");
        }

        return popUpInfo;
    }

    private function parsePopUpFields(fieldsXML:XML):Array
    {
        var fields:Array = [];
        var field:PopUpFieldInfo;

        for each (var fieldXML:XML in fieldsXML.field)
        {
            field = new PopUpFieldInfo();
            field.label = fieldXML.@label;
            field.fieldName = fieldXML.@name;
            field.visible = fieldXML.@visible == "true";
            if (fieldXML.format[0])
            {
                field.format = parsePopUpFieldFormat(fieldXML.format[0]);
            }

            fields.push(field);
        }

        return fields;
    }

    private function parsePopUpFieldFormat(formatXML:XML):PopUpFieldFormat
    {
        var popUpFieldFormat:PopUpFieldFormat = new PopUpFieldFormat();

        if (formatXML.@dateformat[0])
        {
            popUpFieldFormat.dateFormat = formatXML.@dateformat;
        }
        popUpFieldFormat.precision = formatXML.@precision[0] ? formatXML.@precision : -1;
        popUpFieldFormat.useThousandsSeparator = (formatXML.@usethousandsseparator == "true");
        popUpFieldFormat.useUTC = (formatXML.@useutc == "true");

        return popUpFieldFormat;
    }

    private function parsePopUpMedias(mediasXML:XML):Array
    {
        var medias:Array = [];
        var media:PopUpMediaInfo;

        for each (var mediaXML:XML in mediasXML.media)
        {
            media = new PopUpMediaInfo();

            media.caption = mediaXML.@caption;
            if (mediaXML.@chartfields[0])
            {
                media.chartFields = mediaXML.@chartfields.split(',');
            }
            media.chartNormalizationField = mediaXML.@chartnormalizationfield;
            media.imageLinkURL = mediaXML.@imagelinkurl;
            media.imageSourceURL = mediaXML.@imagesourceurl;
            media.title = mediaXML.@title;
            media.type = mapMediaType(mediaXML.@type);

            medias.push(media);
        }

        return medias;
    }

    private function mapMediaType(type:String):String
    {
        var mediaType:String;

        switch (type)
        {
            case "image":
            {
                mediaType = PopUpMediaInfo.IMAGE;
                break;
            }
            case "barchart":
            {
                mediaType = PopUpMediaInfo.BAR_CHART;
                break;
            }
            case "columnchart":
            {
                mediaType = PopUpMediaInfo.COLUMN_CHART;
                break;
            }
            case "linechart":
            {
                mediaType = PopUpMediaInfo.LINE_CHART;
                break;
            }
            case "piechart":
            {
                mediaType = PopUpMediaInfo.PIE_CHART;
                break;
            }
        }

        return mediaType;
    }
}
}
