// ==UserScript==
// @name         Cut off the function of blocking
// @namespace    http://tampermonkey.net/
// @version      2025-02-22
// @description  This script enables right-click, copy, paste, cut, and other functions. Some websites block these actions, preventing users from copying, cutting, selecting, or pasting. This script ensures that these functions are not blocked.
// @author       UmmIt - https://github.com/UmmItC
// @match        https://hkuportal.hku.hk/*
// @match        https://student-portal.hkust.edu.hk/*
// @match        https://portal.cuhk.edu.hk/*
// @match        https://idportal.polyu.edu.hk/*
// @match        https://buniport.hkbu.edu.hk/*
// @match        https://ecampus.hsu.edu.hk/login/*
// @match        https://www.hkmu.edu.hk/current-students/*
// @match        https://soul2.hkuspace.hku.hk/*
// @match        https://myportal.vtc.edu.hk/*
// @match        https://sso.hkct.edu.hk/sso/UI/Login
// @icon         https://avatars.githubusercontent.com/u/128139875?v=4
// @grant        none
// ==/UserScript==

/* Enable editing of the page, useful for testing purposes, dose this work or not?
 *
   document.designMode = 'on';
 *
*/

(function() {
    'use strict';

    // List of events to block
    const events = ['selectstart',
                    'select',
                    'mousedown',
                    'mouseup',
                    'contextmenu',
                    'copy',
                    'keydown',
                    'keyup',
                    'paste',
                    'cut',
                    'drag',
                    'dragstart',
                    ]

    // Block specified events
    events.forEach(event => {
        document.addEventListener(event, e => e.stopPropagation(), true);
    });

    // Override window.alert to prevent popups
    window.alert = function() {};

    // Override window.open to stay in the same tab
    window.open = function(url) {
        // Redirect instead of opening a new tab
        window.location.href = url;
    };

})();
