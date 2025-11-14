CKEDITOR.plugins.add('pre', {
    icons: 'pre',
    init: function (editor) {
        editor.addCommand('cmd-pre', {
            exec: function (editor) {
                
            	
            }
        });

        editor.ui.addButton('pre', {
            label: '미리보기',
            command: 'cmd-pre',
            toolbar: 'custom'
        });
    }
});

function isWhitespace(str) {
    return !str.trim();
}
