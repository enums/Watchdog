/*! @license
*  Project: Buttons
*  Description: A highly customizable CSS button library built with Sass and Compass
*  Author: Alex Wolfe and Rob Levin
*  License: Apache License v2.0
*/
(function($,window,document,undefined){var pluginName="menuButton";var menuClass=".button-dropdown";var defaults={propertyName:"value"};function Plugin(element,options){this.options=$.extend({},defaults,options);this._defaults=defaults;this._name=pluginName;this.$element=$(element);this.init()}Plugin.prototype={constructor:Plugin,init:function(){this.toggle()},toggle:function(el,options){if(this.$element.data("dropdown")==="show"){this.hideMenu()}else{this.showMenu()}},showMenu:function(){this.$element.data("dropdown","show");this.$element.find("ul").show();this.$element.find(".button:first").addClass("is-active")},hideMenu:function(){this.$element.data("dropdown","hide");this.$element.find("ul").hide();this.$element.find(".button:first").removeClass("is-active")}};$.fn[pluginName]=function(options){return this.each(function(){if($.data(this,"plugin_"+pluginName)){$.data(this,"plugin_"+pluginName).toggle()}else{$.data(this,"plugin_"+pluginName,new Plugin(this,options))}})};$(document).on("click",function(e){$.each($("[data-buttons=dropdown]"),function(i,value){if($(e.target.offsetParent)[0]!=$(this)[0]){if($.data(this,"plugin_"+pluginName)){$.data(this,"plugin_"+pluginName).hideMenu();$(this).find("ul").hide()}}})});$(document).on("click","[data-buttons=dropdown]",function(e){var $dropdown=$(e.currentTarget);$dropdown.menuButton()});$(document).on("click","[data-buttons=dropdown] > a",function(e){e.preventDefault()})})(jQuery,window,document);