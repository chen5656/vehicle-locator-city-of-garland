/*global console, define, dojo */
define([
        'dojo/_base/declare', "dojo/query",
        'jimu/BaseWidgetSetting',
        'dijit/_WidgetsInTemplateMixin'
    ],
    function (
        declare, domQuery,
        BaseWidgetSetting,
        _WidgetsInTemplateMixin
    ) {



        return declare([BaseWidgetSetting, _WidgetsInTemplateMixin], {

            baseClass: 'jimu-widget-geofacts-setting',

            startup: function () {
                this.inherited(arguments);
                console.log(1, this.config);
                this.setConfig(this.config);
                var btns = domQuery(".collapsible", this.helpText);
                btns.forEach(function (btn) {
                    btn.addEventListener("click", function () {
                        this.classList.toggle("active");
                        var content = this.nextElementSibling;
                        if (content.style.display === "block") {
                            content.style.display = "none";
                        } else {
                            content.style.display = "block";
                        }
                    });

                })
            },

            setConfig: function (config) {
                this.config = config;
                this.geometryServiceUrl.value = config.settings.geometryServiceUrl;
                this.outSpatialReferenceWkid.value = config.settings.outSpatialReferenceWkid;
                this.geometryCalculationType.value = config.settings.geometryCalculationType;
                this.geometryCalculationAreaUnit.value = config.settings.geometryCalculationAreaUnit.value;
                this.geometryCalculationLengthUnit.value = config.settings.geometryCalculationLengthUnit.value;
                console.log("settings read from file: ", config);
            },

            getConfig: function () {
                settings = this.config.settings;
                settings.geometryServiceUrl = this.geometryServiceUrl.value;
                settings.outSpatialReferenceWkid = this.outSpatialReferenceWkid.value;
                settings.geometryCalculationType = this.geometryCalculationType.value;
                settings.geometryCalculationAreaUnit.value = this.geometryCalculationAreaUnit.value;
                settings.geometryCalculationAreaUnit.name = this.geometryCalculationAreaUnit[this.geometryCalculationAreaUnit.selectedIndex].label;
                settings.geometryCalculationLengthUnit.value = this.geometryCalculationLengthUnit.value;
                settings.geometryCalculationLengthUnit.name =this.geometryCalculationLengthUnit[this.geometryCalculationLengthUnit.selectedIndex].label;
                this.config.settings = settings;
                console.log("settings write to file: " + settings);
                console.log(this.config);
                return this.config;
            }
        });
    });