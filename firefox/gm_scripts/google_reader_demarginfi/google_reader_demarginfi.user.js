// ==UserScript==
// @name           Google Reader Demarginfier
// @namespace      http://www.aintaer.com/Projects
// @description    Reduces margins on the new Google Reader layout
// @include        http://www.google.com/reader/view/*
// @include        https://www.google.com/reader/view/*
// @version        1.2
// ==/UserScript==

var overrideCSS = " \
#top-bar { height:45px !important; } \
#search { padding:8px 0 !important; } \
#viewer-header { height:45px !important; } \
#lhn-add-subscription-section { height:45px !important; } \
#lhn-add-subscription, #viewer-top-controls-container \
{ margin-top:-15px !important; } \
#entries { padding:0 !important; } \
#title-and-status-holder { padding:0.3ex 0 0 0.5em !important; } \
.collapsed { line-height:2.2ex !important; padding:2px 0 !important; } \
.entry-icons { top:0 !important } \
.entry-source-title { top:2px !important } \
.entry-secondary { top:2px !important } \
.entry-main .entry-original { top:4px !important } \
.section-minimize { left: 0px !important } \
#overview-selector, #lhn-selectors .selector, .folder .name.name-d-0, \
#sub-tree-header \
{ padding-left: 15px !important; } \
.folder .folder .folder-toggle { margin-left:13px !important } \
.folder .sub-icon, .folder .folder>a>.icon { margin-left:27px !important } \
.folder .folder>ul .icon { margin-left:34px !important } \
.folder .folder .name-text { max-width:160px; !important } \
#reading-list-selector .label { display:inline !important } \
";
GM_addStyle(overrideCSS);
