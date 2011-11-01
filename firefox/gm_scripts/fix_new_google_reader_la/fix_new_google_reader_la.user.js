// ==UserScript==
// @name           Fix New Google Reader Layout
// @namespace      http://www.stealthmonkey.com
// @description    Fixes some UI flaws in the new Google Reader layout
// @include        http*://www.google.*/reader/*
// ==/UserScript==

// Add Card Border
GM_addStyle(".card { border: #CBCBCB solid 1px; }");

// Add Navbar Border
GM_addStyle("#scrollable-sections-holder { border-right: #EBEBEB solid 1px; }");

// Fix Card Margin & Padding
GM_addStyle(".card { margin-left: 10px; margin-right: 9px; padding-right: 8px; }");

// Fix Card Footer Size
GM_addStyle(".card-bottom { margin-left: -14px; margin-right: -9px; margin-bottom: -1px; }");
GM_addStyle(".entry .star { height: 12px; margin-right: -3px; }");

// Hide Google+
GM_addStyle(".item-plusone { display: none !important; }");
