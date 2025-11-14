/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */



CKEDITOR.editorConfig = function( config ) {
    // Define changes to default configuration here. For example:
    // config.language = 'fr';
    // config.uiColor = '#AADC6E';
    config.allowedContent = true;
    
    // 글꼴추가
    config.contentsCss = 'publish/mgr/js/ckeditor/contents.css';
    config.font_names = 'Pretendard-Regular/Pretendard-Regular, sans-serif;' + config.font_names;
    
    config.toolbar = [
        { name: 'document', groups: [ 'mode', 'document', 'doctools' ], items: [ 'Source','Preview'] },
        { name: 'editing', groups: [ 'find'], items: [ 'Find'] },
        { name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Undo', 'Redo'] },
        { name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut','Copy','Paste'] },
        { name: 'links', groups:['links','insert'], items: [ 'Link'] },
        { name: 'custom', items:['addImage']},
        //'/', <=줄바꿈 주석처리
        { name: 'styles', items: [ 'Font', 'FontSize' ] },
        { name: 'colors', items: [ 'TextColor', 'BGColor' ] },
        { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
        { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ], items: [ 'CreateDiv', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
        //'/',
        { name: 'tools', items: [ 'Maximize', 'ShowBlocks' ] }
    ];
    
    config.extraPlugins = 'title,subtitle,remove,ptitle,subptitle,addImage';
    
    };

CKEDITOR.style.customHandler= function( config ) {

};